local M = {}
-- local function lsp_highlight_document(client)
--     if client.server_capabilities.documentHighlightProvider then
--         vim.api.nvim_command([[
--               augroup lsp_document_highlight
--                 autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--                 autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--             ]])
--     end
--     -- autocmd CursorHold <buffer> lua vim.diagnostic.open_float(0, {scope="line"})
-- end

-- TODO: register these with which key instead
local function lsp_keymaps(client, bufnr)
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gm", "<cmd>Telescope lsp_document_symbols<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { buffer = bufnr })
    -- vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<cr>", { buffer = bufnr })
    vim.keymap.set("n", "K", require("hover").hover, { buffer = bufnr })
    vim.keymap.set("n", "gK", require("hover").hover_select, { buffer = bufnr })
    vim.keymap.set("n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = bufnr })
    -- vim.keymap.set("n", "<leader>lh", "<cmd>Lspsaga signature_help<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr })
    -- vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_workspace_symbols<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<space>lr", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { buffer = bufnr, expr = true })
    -- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = false })' ]])

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.document_formatting then
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, async = true })
    end
    if client.server_capabilities.document_range_formatting then
        vim.keymap.set("v", "<leader>cf", vim.lsp.buf.range_format, { buffer = bufnr, async = true })
    end
end

-- formatting is now handled by conform.nvim
-- local no_format_servers = {
--     "tsserver",
--     "typescript-tools.nvim",
--     "typescript-tools",
--     "hls",
--     "haskell-tools.nvim",
--     "lua_ls",
--     "sqls",
--     "dockerls",
-- }
--
-- local lsp_formatting = function(bufnr)
--     vim.lsp.buf.format({
--         filter = function(client)
--             -- filter out clients that you don't want to use
--             for _, name in pairs(no_format_servers) do
--                 if name == client.name then
--                     return false
--                 end
--             end
--             return true
--         end,
--         bufnr = bufnr,
--     })
-- end
--
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
-- add to your shared on_attach callback
-- local lsp_format = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--         vim.api.nvim_create_autocmd("BufWritePre", {
--             group = augroup,
--             buffer = bufnr,
--             callback = function()
--                 -- lsp_formatting(bufnr)
--             end,
--         })
--     end
-- end

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = vim.api.nvim_create_augroup("TS_organize_imports", { clear = true }),
--     desc = "TS_organize_imports",
--     pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
--     callback = function()
--         -- vim.cmd([[TSToolsAddMissingImports]])
--         -- vim.cmd("write")
--         vim.cmd([[TSToolsOrganizeImports]])
--         vim.cmd("write")
--     end,
-- })

local lsp_inlay_hints = function(client, bufnr)
    if client.supports_method("textDocument/inlayHint") and vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(client, bufnr)
    -- lsp_highlight_document(client)
    -- lsp_format(client, bufnr)
    lsp_inlay_hints(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
--local capabilities = require("cmp_nvim_lsp").default_capabilities()

M.capabilities = capabilities

return M
