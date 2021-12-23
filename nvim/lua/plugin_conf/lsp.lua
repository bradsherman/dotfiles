local map = require("utils").map
local nvim_lsp = require("lspconfig")

-- local signs = {
--   { name = "DiagnosticSignError", text = "" },
--   { name = "DiagnosticSignWarn", text = "" },
--   { name = "DiagnosticSignHint", text = "" },
--   { name = "DiagnosticSignInfo", text = "" },
-- }

local signs = {
	{ name = "DiagnosticSignError", text = "❌" },
	{ name = "DiagnosticSignWarn", text = "⚠️ " },
	{ name = "DiagnosticSignHint", text = "💡" },
	{ name = "DiagnosticSignInfo", text = "ℹ️ " },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	virtual_text = false,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

require("lsp_signature").on_attach()

local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	buf_set_keymap("n", "<leader>lh", "<cmd>Lspsaga signature_help<CR>", opts)
	buf_set_keymap("n", "<leader>la", "<cmd>Telescope lsp_code_actions<cr>", opts)
	buf_set_keymap("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", opts)
	buf_set_keymap("n", "<leader>ls", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
	buf_set_keymap("n", "<space>le", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	buf_set_keymap("n", "<space>lr", '<cmd>lua require("renamer").rename()<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	end
	if client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("v", "<leader>cf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	require("illuminate").on_attach(client)
end

-- loop over default servers
local servers_default = {
	"ansiblels",
	"rust_analyzer",
	"bashls",
	"dockerls",
	"graphql",
	"dhall_lsp_server",
	"jsonls",
	"julials",
	-- need to do special setup
	--"sqlls",
	"terraformls",
	"vimls",
	"pyright",
}

local bare_capabilities = vim.lsp.protocol.make_client_capabilities()

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").update_capabilities(bare_capabilities)

for _, lsp in ipairs(servers_default) do
	nvim_lsp[lsp].setup({ on_attach = on_attach, capabilities = capabilities })
end

-- special setup for haskell & lua
nvim_lsp.hls.setup({
	settings = {
		haskell = {
			formattingProvider = "fourmolu",
		},
	},
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = true
		on_attach(client)
	end,
	capabilities = capabilities,
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				enable = true,
				globals = { "vim" },
			},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.tsserver.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({
			eslint_bin = "eslint_d",
			eslint_enable_diagnostics = true,
			eslint_enable_code_actions = true,
			enable_formatting = true,
			formatter = "prettier",
		})
		ts_utils.setup_client(client)

		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.completion.spell,
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

nvim_lsp.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
map("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
map("n", "gm", "<cmd>Telescope lsp_document_symbols<cr>", opts)
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
map("n", "gD", "<cmd>Lspsaga preview_definition<cr>", opts)
map("n", "<leader>lt", "<cmd>:LspTroubleToggle<cr>", opts)
map("n", "<leader>ltr", "<cmd>:LspTroubleRefresh<cr>", opts)
map("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
map("n", "<c-p>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
map("n", "<c-n>", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)

-- Illuminate
map("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
map("n", "<a-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')
vim.g.Illuminate_delay = 100
