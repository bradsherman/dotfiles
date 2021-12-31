local M = {}

M.setup = function()
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

	vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
	vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
	vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])
end

local function lsp_highlight_document(client)
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    ]],
			false
		)
	end
end

local function lsp_keymaps(client, bufnr)
	local opts = { noremap = true, silent = true }
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
	buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
	buf_set_keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
	buf_set_keymap("n", "gm", "<cmd>Telescope lsp_document_symbols<cr>", opts)
	buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
	buf_set_keymap("n", "gD", "<cmd>Lspsaga preview_definition<cr>", opts)
	buf_set_keymap("n", "<leader>lt", "<cmd>:LspTroubleToggle<cr>", opts)
	buf_set_keymap("n", "<leader>ltr", "<cmd>:LspTroubleRefresh<cr>", opts)
	buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
	buf_set_keymap("n", "<c-p>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	buf_set_keymap("n", "<c-n>", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	buf_set_keymap("n", "<leader>lh", "<cmd>Lspsaga signature_help<CR>", opts)
	buf_set_keymap("n", "<leader>la", "<cmd>Telescope lsp_code_actions<cr>", opts)
	buf_set_keymap("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", opts)
	buf_set_keymap("n", "<leader>ls", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
	buf_set_keymap("n", "<space>le", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	buf_set_keymap("n", "<space>lr", '<cmd>lua require("renamer").rename()<CR>', opts)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		-- TODO: maybe change to :Format
		buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	end
	if client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("v", "<leader>cf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
	require("lsp_signature").on_attach()
	lsp_keymaps(client, bufnr)
	-- TODO: this throws errors when lsp hasn't finished starting
	--lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
