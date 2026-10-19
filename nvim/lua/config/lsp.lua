vim.opt.completeopt = "menu,menuone,noselect,popup" -- Ensures the menu appears even for a single match and uses the native popup window.
vim.o.autocomplete = true -- Enables the overall completion feature.

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
	callback = function(args)
		local client_id = args.data.client_id
		if not client_id then
			return
		end

		local client = vim.lsp.get_client_by_id(client_id)
		if client and client:supports_method("textDocument/completion") then
			-- Enable native LSP completion for this client + buffer
			vim.lsp.completion.enable(true, client_id, args.buf, {
				autotrigger = true, -- auto-show menu as you type (recommended)
				-- You can also set { autotrigger = false } and trigger manually with <C-x><C-o>
			})
		end
	end,
})

-- LSP keymaps (buffer-local, set when a server attaches). List-style navigation
-- uses fzf-lua when available; rename/code-action/hover use native LSP.
-- Note: grn/gra/grr/gri/K are Neovim 0.11+ defaults — these refine them.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
	callback = function(args)
		local has_fzf = pcall(require, "fzf-lua")
		local function pick(cmd, fallback)
			return function()
				if has_fzf then
					vim.cmd("FzfLua " .. cmd)
				else
					fallback()
				end
			end
		end
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true, desc = "LSP: " .. desc })
		end

		map("n", "gd", pick("lsp_definitions", vim.lsp.buf.definition), "Goto definition")
		map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
		map("n", "gy", pick("lsp_typedefs", vim.lsp.buf.type_definition), "Goto type definition")
		map("n", "gri", pick("lsp_implementations", vim.lsp.buf.implementation), "Goto implementation")
		map("n", "grr", pick("lsp_references", vim.lsp.buf.references), "References")
		map("n", "grn", vim.lsp.buf.rename, "Rename symbol")
		map({ "n", "x" }, "gra", vim.lsp.buf.code_action, "Code action")
		map("n", "K", function()
			vim.lsp.buf.hover()
		end, "Hover docs")
		map("n", "gK", vim.lsp.buf.hover, "Hover docs (repeat to focus)")
		map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
		-- Familiar shortcuts from the full config, backed by native LSP/FzfLua.
		map("n", "gR", pick("lsp_references", vim.lsp.buf.references), "References")
		map("n", "gt", pick("lsp_typedefs", vim.lsp.buf.type_definition), "Goto type definition")
		map("n", "gm", pick("lsp_document_symbols", vim.lsp.buf.document_symbol), "Document symbols")
		map("n", "gi", pick("lsp_implementations", vim.lsp.buf.implementation), "Goto implementation")
		map("n", "<C-p>", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Previous diagnostic")
		map("n", "<C-n>", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Next diagnostic")
		map({ "n", "x" }, "<leader>la", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>ld", "<cmd>FzfLua diagnostics_workspace<cr>", "Workspace diagnostics")
		map("n", "<leader>ls", "<cmd>FzfLua lsp_workspace_symbols<cr>", "Workspace symbols")
		map("n", "<leader>lr", vim.lsp.buf.rename, "Rename symbol")
		map("n", "<leader>lf", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, "Format buffer")
		map("x", "<leader>cf", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, "Format selection")
	end,
})

-- LSP: enable servers defined in `lsp/<name>.lua`, but only when their binary
-- is installed — so uninstalled servers don't throw "cmd not executable".
-- Install the missing ones via nix and they light up automatically.
local servers = {
	"hls",
	"lua_ls",
	"pyright",
	"ruff",
	"ts_ls",
	"nil_ls",
	"bashls",
	"terraformls",
	"yamlls",
	"jsonls",
	"dockerls",
	"rust_analyzer",
}
for _, name in ipairs(servers) do
	local cfg = vim.lsp.config[name]
	local exe = cfg and cfg.cmd and cfg.cmd[1]
	if exe and vim.fn.executable(exe) == 1 then
		vim.lsp.enable(name)
	end
end

-- Make diagnostics actually visible (virtual_text is OFF by default in Neovim).
vim.diagnostic.config({
	virtual_text = { spacing = 2, prefix = "\xe2\x97\x8f", source = "if_many" }, -- ●
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "\xee\xaa\x87", -- U+EA87
			[vim.diagnostic.severity.WARN] = "\xee\xa9\xac", -- U+EA6C
			[vim.diagnostic.severity.INFO] = "\xee\xa9\xb4", -- U+EA74
			[vim.diagnostic.severity.HINT] = "\xee\xa9\xa1", -- U+EA61
		},
	},
})

vim.api.nvim_create_user_command("LspStatus", function()
	local lines = {}
	for _, name in ipairs(servers) do
		local cfg = vim.lsp.config[name]
		local exe = cfg.cmd[1]
		local attached = #vim.lsp.get_clients({ name = name, bufnr = 0 }) > 0
		lines[#lines + 1] = string.format(
			"%s: %s; %s%s",
			name,
			vim.fn.executable(exe) == 1 and "installed" or ("missing " .. exe),
			vim.lsp.is_enabled(name) and "enabled" or "disabled",
			attached and "; attached" or ""
		)
	end
	vim.notify(table.concat(lines, "\n"))
end, { desc = "Show configured LSP availability and attachment" })
