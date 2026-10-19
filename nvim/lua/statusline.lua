-- Native statusline (no plugins). "Slanted blocks" style.
-- Rendered via `vim.o.statusline = "%{%v:lua.require('statusline').render()%}"`
-- so the returned string is re-parsed for highlight (%#..#) and format (%l, %p) items.
local M = {}

-- Kanagawa-wave palette (subset). Self-contained so this does not depend on
-- kanagawa internals; tweak freely or swap if you change colorscheme.
local P = {
	base = "#16161D", -- statusline background (sumiInk0)
	blk1 = "#2A2A37", -- sumiInk4  (git / lsp blocks)
	blk2 = "#363646", -- sumiInk5  (file / filetype blocks)
	fg = "#DCD7BA", -- fujiWhite
	fg_dim = "#727169", -- fujiGray
	blue = "#7E9CD8", -- crystalBlue   (normal)
	sky = "#7FB4CA", -- springBlue    (accents)
	green = "#98BB6C", -- springGreen   (insert)
	violet = "#957FB8", -- oniViolet     (visual)
	red = "#E46876", -- waveRed       (replace)
	yellow = "#E6C384", -- carpYellow    (command)
	aqua = "#7AA89F", -- waveAqua2     (terminal)
	diag_error = "#E82424",
	diag_warn = "#FF9E3B",
	diag_info = "#658594",
	diag_hint = "#6A9589",
	diff_add = "#76946A",
	diff_del = "#C34043",
}

-- Glyphs (Nerd Font), written as UTF-8 byte escapes so they can't be stripped
-- by an editor/encoding step. Comments give the codepoint.
local SLANT_L = "\xee\x82\xbc" -- U+E0BC  slant, between left-aligned blocks
local SLANT_R = "\xee\x82\xbe" -- U+E0BE  slant, between right-aligned blocks
local ICON = {
	branch = "\xee\x82\xa0", -- U+E0A0  branch
	modified = "\xe2\x97\x8f", -- U+25CF  ●
	readonly = "\xef\x80\xa3", -- U+F023  lock
	error = "\xee\xaa\x87", -- U+EA87  codicon error
	warn = "\xee\xa9\xac", -- U+EA6C  codicon warning
	info = "\xee\xa9\xb4", -- U+EA74  codicon info
	hint = "\xee\xa9\xa1", -- U+EA61  codicon lightbulb
	lsp = "\xef\x82\x85", -- U+F085  cog
}

local has_devicons, devicons = pcall(require, "nvim-web-devicons")

----------------------------------------------------------------------
-- Highlight groups: created on demand and cached by color pair.
----------------------------------------------------------------------
local hl_cache = {}

local function hl(fg, bg, bold)
	local key = string.format("%s_%s_%s", fg or "NONE", bg or "NONE", bold and "b" or "n")
	local name = "Stl_" .. key:gsub("#", "")
	if not hl_cache[name] then
		vim.api.nvim_set_hl(0, name, { fg = fg, bg = bg, bold = bold or false })
		hl_cache[name] = true
	end
	return name
end

local function setup_base_hl()
	vim.api.nvim_set_hl(0, "StatusLine", { fg = P.fg, bg = P.base })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = P.fg_dim, bg = P.base })
end

----------------------------------------------------------------------
-- Components
----------------------------------------------------------------------
local MODES = {
	n = { "NORMAL", P.blue },
	no = { "O-PEND", P.blue },
	niI = { "NORMAL", P.blue },
	v = { "VISUAL", P.violet },
	V = { "V-LINE", P.violet },
	["\22"] = { "V-BLOCK", P.violet },
	s = { "SELECT", P.violet },
	S = { "S-LINE", P.violet },
	i = { "INSERT", P.green },
	ic = { "INSERT", P.green },
	R = { "REPLACE", P.red },
	Rv = { "V-REPL", P.red },
	c = { "COMMAND", P.yellow },
	cv = { "EX", P.yellow },
	r = { "PROMPT", P.yellow },
	["!"] = { "SHELL", P.yellow },
	t = { "TERMINAL", P.aqua },
}

local function mode_info()
	local code = vim.api.nvim_get_mode().mode
	local m = MODES[code] or MODES[code:sub(1, 1)] or { code:upper(), P.blue }
	return m[1], m[2]
end

local function file_icon()
	if not has_devicons then
		return ""
	end
	local name = vim.fn.expand("%:t")
	local ext = vim.fn.expand("%:e")
	local icon = devicons.get_icon(name, ext, { default = true })
	return icon or ""
end

local function filename()
	local name = vim.fn.expand("%:t")
	if name == "" then
		local ft = vim.bo.filetype
		return ft ~= "" and ("[" .. ft .. "]") or "[No Name]"
	end
	return name
end

local function file_flags()
	if vim.bo.modified then
		return " " .. ICON.modified
	end
	if vim.bo.readonly or not vim.bo.modifiable then
		return " " .. ICON.readonly
	end
	return ""
end

-- Keep work-done tokens until their end event; vim.lsp.status() consumes its
-- queue, so calling it during renders would make progress disappear on redraw.
local lsp_progress = {}
local function lsp_names()
	local parts = {}
	local buf = vim.api.nvim_get_current_buf()
	for _, client in ipairs(vim.lsp.get_clients()) do
		local tasks = lsp_progress[client.id] or {}
		if client.attached_buffers[buf] or next(tasks) then
			local messages = {}
			for _, task in pairs(tasks) do
				local text = task.title or "Working"
				if task.message and task.message ~= "" then
					text = text .. ": " .. task.message
				end
				if task.percentage then
					text = text .. " " .. task.percentage .. "%"
				end
				messages[#messages + 1] = text
			end
			table.sort(messages)
			local label = client.name
			if not client.initialized then
				label = label .. ": starting…"
			elseif #messages > 0 then
				label = label .. ": " .. table.concat(messages, "; ")
			end
			-- Server text is untrusted statusline content: escape percent codes.
			label = label:gsub("[\r\n]", " ")
			if vim.fn.strchars(label) > 100 then
				label = vim.fn.strcharpart(label, 0, 97) .. "…"
			end
			parts[#parts + 1] = label:gsub("%%", "%%%%")
		end
	end
	table.sort(parts)
	if #parts == 0 then
		return vim.bo.buftype == "" and "LSP: none" or ""
	end
	return table.concat(parts, " | ")
end

local function diagnostics(base)
	local c = vim.diagnostic.count(vim.api.nvim_get_current_buf())
	local out = {}
	local order = {
		{ vim.diagnostic.severity.ERROR, ICON.error, P.diag_error },
		{ vim.diagnostic.severity.WARN, ICON.warn, P.diag_warn },
		{ vim.diagnostic.severity.INFO, ICON.info, P.diag_info },
		{ vim.diagnostic.severity.HINT, ICON.hint, P.diag_hint },
	}
	for _, s in ipairs(order) do
		local n = c[s[1]] or 0
		if n > 0 then
			out[#out + 1] = "%#" .. hl(s[3], base) .. "# " .. s[2] .. " " .. n .. " "
		end
	end
	return table.concat(out)
end

local function gitdiff(base)
	local d = vim.b.statusline_gitdiff
	if not d then
		return ""
	end
	local out = {}
	if (d.added or 0) > 0 then
		out[#out + 1] = "%#" .. hl(P.diff_add, base) .. "# +" .. d.added .. " "
	end
	if (d.removed or 0) > 0 then
		out[#out + 1] = "%#" .. hl(P.diff_del, base) .. "#-" .. d.removed .. " "
	end
	return table.concat(out)
end

----------------------------------------------------------------------
-- Render
----------------------------------------------------------------------
function M.render()
	local base = P.base
	local mlabel, mcolor = mode_info()

	-- Left blocks (stitched with SLANT_L; each block's bg slants into the next).
	-- Each block is { text, fg, bg, bold }.
	local branch = vim.b.statusline_branch
	local left = { { " " .. mlabel .. " ", base, mcolor, true } }
	if branch and branch ~= "" then
		left[#left + 1] = { " " .. ICON.branch .. " " .. branch .. " ", P.sky, P.blk1 }
	end
	left[#left + 1] = { " " .. file_icon() .. " " .. filename() .. file_flags() .. " ", P.fg, P.blk2 }

	local out = {}
	for i, s in ipairs(left) do
		local text, fg, bg, bold = s[1], s[2], s[3], s[4]
		out[#out + 1] = "%#" .. hl(fg, bg, bold) .. "#" .. text
		local next_bg = left[i + 1] and left[i + 1][3] or base
		out[#out + 1] = "%#" .. hl(bg, next_bg) .. "#" .. SLANT_L
	end
	out[#out + 1] = "%#StatusLine# " .. gitdiff(base)

	-- Right blocks (stitched with SLANT_R; rendered left->right with leading slants).
	local right = {}
	local lsp = lsp_names()
	if lsp ~= "" then
		right[#right + 1] = { " " .. ICON.lsp .. " " .. lsp .. " ", P.sky, P.blk1 }
	end
	if vim.bo.filetype ~= "" then
		right[#right + 1] = { " " .. file_icon() .. " " .. vim.bo.filetype .. " ", P.fg, P.blk2 }
	end
	right[#right + 1] = { " %l:%c  %p%% ", base, mcolor, true } -- position bookend in mode color

	local rout = {}
	local prev = base
	for _, s in ipairs(right) do
		local text, fg, bg, bold = s[1], s[2], s[3], s[4]
		rout[#rout + 1] = "%#" .. hl(bg, prev) .. "#" .. SLANT_R
		rout[#rout + 1] = "%#" .. hl(fg, bg, bold) .. "#" .. text
		prev = bg
	end

	return table.concat(out) .. "%#StatusLine#%=" .. diagnostics(base) .. table.concat(rout)
end

----------------------------------------------------------------------
-- VCS info. Prefers jujutsu (jj) when a `.jj` dir is found, else git.
-- Branch/change is shown in `statusline_branch`; +/- counts in
-- `statusline_gitdiff`. All commands run async via vim.system.
----------------------------------------------------------------------
local function find_up(name, start)
	return vim.fs.find(name, { path = start, upward = true, limit = 1 })[1]
end

-- Schedule-safe setters that redraw the bar once data arrives.
local function set_branch(buf, branch)
	vim.schedule(function()
		if vim.api.nvim_buf_is_valid(buf) then
			vim.b[buf].statusline_branch = branch
			vim.cmd("redrawstatus")
		end
	end)
end

local function set_diff(buf, stdout, code)
	local added, removed = 0, 0
	if code == 0 and stdout then
		added = tonumber(stdout:match("(%d+) insertion")) or 0
		removed = tonumber(stdout:match("(%d+) deletion")) or 0
	end
	vim.schedule(function()
		if vim.api.nvim_buf_is_valid(buf) then
			vim.b[buf].statusline_gitdiff = { added = added, removed = removed }
			vim.cmd("redrawstatus")
		end
	end)
end

-- jj: show bookmarks if any, else the shortest unique change id.
-- `--ignore-working-copy` avoids snapshotting/locking the repo on every redraw.
local function update_jj(buf, dir)
	vim.system({
		"jj",
		"log",
		"-r",
		"@",
		"--no-graph",
		"--ignore-working-copy",
		"--color",
		"never",
		"-T",
		'change_id.shortest(8) ++ if(bookmarks, " " ++ bookmarks.join(","), "")',
	}, { cwd = dir, text = true }, function(o)
		set_branch(buf, o.code == 0 and o.stdout and vim.trim(o.stdout) or "")
	end)
	vim.system({ "jj", "diff", "--stat", "-r", "@", "--ignore-working-copy" }, { cwd = dir, text = true }, function(o)
		set_diff(buf, o.stdout, o.code)
	end)
end

local function read_branch(start)
	local found = vim.fs.find(".git", { path = start, upward = true, limit = 1 })[1]
	if not found then
		return ""
	end
	local head_file
	local st = vim.uv.fs_stat(found)
	if st and st.type == "directory" then
		head_file = found .. "/HEAD"
	else -- worktree/submodule: .git is a file "gitdir: <path>"
		local f = io.open(found, "r")
		if not f then
			return ""
		end
		local line = f:read("*l")
		f:close()
		local gd = line and line:match("^gitdir:%s*(.+)$")
		if not gd then
			return ""
		end
		head_file = gd .. "/HEAD"
	end
	local hf = io.open(head_file, "r")
	if not hf then
		return ""
	end
	local content = hf:read("*l")
	hf:close()
	if not content then
		return ""
	end
	return content:match("ref:%s*refs/heads/(.+)$") or content:sub(1, 7) -- branch or detached short-sha
end

local function update_git(buf, dir)
	local branch = read_branch(dir)
	vim.b[buf].statusline_branch = branch
	if branch == "" or vim.fn.executable("git") ~= 1 then
		vim.b[buf].statusline_gitdiff = nil
		return
	end
	vim.system({ "git", "--no-optional-locks", "diff", "--shortstat" }, { cwd = dir, text = true }, function(o)
		set_diff(buf, o.stdout, o.code)
	end)
end

-- Plugin buffers are named with a URI (`oil:///abs/path`, `fugitive://`,
-- `term://`), which is not a usable cwd -- passing one to vim.system raises
-- ENOENT, and vim.fs.find treats it as relative and walks up from the editor
-- cwd instead. Strip a scheme prefix and fall back to the cwd unless what is
-- left is a real directory on disk.
local function buf_dir(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" then
		return vim.fn.getcwd()
	end
	local path = name:match("^%a[%w+.%-]*://(.*)$") or name
	local dir = vim.fn.isdirectory(path) == 1 and path or vim.fs.dirname(path)
	return vim.fn.isdirectory(dir) == 1 and dir or vim.fn.getcwd()
end

-- Dispatch: jj wins for colocated repos (you use jj), else git.
local function update_vcs(buf)
	buf = (buf and buf ~= 0) and buf or vim.api.nvim_get_current_buf()
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end
	local dir = buf_dir(buf)

	if find_up(".jj", dir) and vim.fn.executable("jj") == 1 then
		vim.b[buf].statusline_vcs = "jj"
		update_jj(buf, dir)
	else
		vim.b[buf].statusline_vcs = "git"
		update_git(buf, dir)
	end
end

----------------------------------------------------------------------
-- Setup
----------------------------------------------------------------------
setup_base_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("StatuslineColors", { clear = true }),
	callback = function()
		hl_cache = {}
		setup_base_hl()
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "FocusGained", "DirChanged" }, {
	group = vim.api.nvim_create_augroup("StatuslineVcs", { clear = true }),
	callback = function(args)
		update_vcs(args.buf)
	end,
})

vim.schedule(update_vcs)
vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach", "LspProgress" }, {
	group = vim.api.nvim_create_augroup("StatuslineLsp", { clear = true }),
	callback = function(args)
		if args.event == "LspProgress" then
			local data = args.data or {}
			local params = data.params or {}
			local value = params.value
			if data.client_id and params.token ~= nil and type(value) == "table" and value.kind then
				local tasks = lsp_progress[data.client_id] or {}
				lsp_progress[data.client_id] = tasks
				if value.kind == "end" then
					tasks[params.token] = nil
				else
					tasks[params.token] = vim.tbl_extend("force", tasks[params.token] or {}, value)
				end
			end
		end
		vim.schedule(function()
			vim.cmd("redrawstatus")
		end)
	end,
})
vim.o.statusline = "%{%v:lua.require('statusline').render()%}"

return M
