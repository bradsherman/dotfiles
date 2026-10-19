local lint = require("lint")
local M = {}

-- Walk upward so monorepo-local executables work even when Neovim's cwd is elsewhere.
local function biome_command()
	local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
	while dir and dir ~= "" do
		local candidate = vim.fs.joinpath(dir, "node_modules", ".bin", "biome")
		if vim.fn.executable(candidate) == 1 then
			return candidate
		end
		local parent = vim.fs.dirname(dir)
		if parent == dir then
			break
		end
		dir = parent
	end
	return "biome"
end

-- Biome's JSON reporter avoids parsing colored, version-dependent terminal text.
local function position(source, offset)
	local prefix = source:sub(1, offset)
	local _, lines = prefix:gsub("\n", "")
	return lines, #(prefix:match("[^\n]*$") or "")
end
function M.parse_biome(output, bufnr)
	if output == "" then
		return {}
	end
	local ok, report = pcall(vim.json.decode, output)
	if not ok or type(report) ~= "table" or type(report.diagnostics) ~= "table" then
		return {
			{
				lnum = 0,
				col = 0,
				severity = vim.diagnostic.severity.ERROR,
				source = "biome",
				message = "Biome returned invalid JSON; check :LintInfo and the Biome configuration",
			},
		}
	end
	local result = {}
	for _, item in ipairs(report.diagnostics) do
		local location = item.location or {}
		local source = location.sourceCode
		if type(source) ~= "string" then
			source = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
		end
		local span = type(location.span) == "table" and location.span or { 0, 0 }
		local row, col = position(source, span[1] or 0)
		local end_row, end_col = position(source, span[2] or span[1] or 0)
		-- Newer Biome reporters provide one-based line/column positions.
		if location.start then
			row, col = location.start.line - 1, location.start.column - 1
			local finish = location["end"] or location.start
			end_row, end_col = finish.line - 1, finish.column - 1
		end
		local severities = {
			fatal = vim.diagnostic.severity.ERROR,
			error = vim.diagnostic.severity.ERROR,
			warning = vim.diagnostic.severity.WARN,
			information = vim.diagnostic.severity.INFO,
			hint = vim.diagnostic.severity.HINT,
		}
		result[#result + 1] = {
			lnum = row,
			col = col,
			end_lnum = end_row,
			end_col = end_col,
			severity = severities[item.severity] or vim.diagnostic.severity.WARN,
			source = "biome",
			code = item.category,
			message = item.description
				or (type(item.message) == "string" and item.message)
				or item.category
				or "Biome diagnostic",
		}
	end
	return result
end
lint.linters.biomejs = {
	cmd = biome_command,
	args = { "lint", "--reporter=json", "--colors=off" },
	stdin = false,
	stream = "stdout",
	ignore_exitcode = true,
	parser = M.parse_biome,
}
local web = { "biomejs" }
lint.linters_by_ft = {
	sh = { "shellcheck" },
	bash = { "shellcheck" },
	haskell = { "hlint" },
	sql = { "sqlfluff" },
	lua = { "selene" },
	javascript = web,
	javascriptreact = web,
	typescript = web,
	typescriptreact = web,
	json = web,
	jsonc = web,
}
-- Retain the PostgreSQL default, stdin marker, and upstream SQLFluff parser.
lint.linters.sqlfluff.args = { "lint", "--format=json", "--dialect=postgres", "-" }

local function available(name)
	local spec = lint.linters[name]
	if type(spec) == "function" then
		spec = spec()
	end
	local cmd = type(spec.cmd) == "function" and spec.cmd() or spec.cmd
	return vim.fn.executable(cmd) == 1, cmd, spec
end
function M.run()
	if vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == "" then
		return
	end
	local names = {}
	for _, name in ipairs(lint.linters_by_ft[vim.bo.filetype] or {}) do
		local ok, _, spec = available(name)
		-- File-based Biome diagnostics must correspond to the saved buffer.
		if ok and (spec.stdin or (not vim.bo.modified and vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 1)) then
			names[#names + 1] = name
		end
	end
	if #names > 0 then
		local root = vim.fs.root(0, { "biome.json", "biome.jsonc", "package.json", ".jj", ".git" })
		lint.try_lint(names, { cwd = root or vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
	end
end
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("EditorLint", { clear = true }),
	callback = M.run,
})
vim.api.nvim_create_user_command("Lint", M.run, { desc = "Lint current buffer" })
vim.api.nvim_create_user_command("LintInfo", function()
	local lines = {}
	for _, name in ipairs(lint.linters_by_ft[vim.bo.filetype] or {}) do
		local ok, cmd = available(name)
		lines[#lines + 1] = name .. ": " .. cmd .. (ok and " (available)" or " (not installed)")
	end
	vim.notify(#lines > 0 and table.concat(lines, "\n") or "No standalone linter configured for this filetype")
end, { desc = "Show configured linters and executable availability" })
return M
