local M = {}

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false,
        -- show signs
        sign = true,
        -- signs = {
        --     active = false,
        -- },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    --[[ vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { ]]
    --[[     border = "rounded", ]]
    --[[ }) ]]
    --[[]]
    --[[ vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { ]]
    --[[     border = "rounded", ]]
    --[[ }) ]]

    vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
    vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
    vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])
end

local function lsp_highlight_document(client)
    if client.server_capabilities.documentHighlightProvider then
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
    -- autocmd CursorHold <buffer> lua vim.diagnostic.open_float(0, {scope="line"})
end

-- TODO: register these with which key instead
local function lsp_keymaps(client, bufnr)
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gm", "<cmd>Telescope lsp_document_symbols<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<cr>", { buffer = bufnr })
    vim.keymap.set("n", "K", require("hover").hover, { buffer = bufnr })
    vim.keymap.set("n", "gK", require("hover").hover_select, { buffer = bufnr })
    vim.keymap.set("n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>lh", "<cmd>Lspsaga signature_help<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_workspace_symbols<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<space>le", "<cmd>Lspsaga show_line_diagnostics<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<space>lr", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { buffer = bufnr, expr = true })
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
    vim.keymap.set("n", "vv", "<cmd>lua require('lsp-selection-range').trigger()<CR>", { buffer = bufnr })
    vim.keymap.set("n", "ve", "<cmd>lua require('lsp-selection-range').expand()<CR>", { buffer = bufnr })

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.document_formatting then
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, async = true })
    end
    if client.server_capabilities.document_range_formatting then
        vim.keymap.set("v", "<leader>cf", vim.lsp.buf.range_format, { buffer = bufnr, async = true })
    end
end

local no_format_servers = { "tsserver", "hls", "haskell-tools.nvim", "lua_ls", "sqls", "dockerls" }

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- filter out clients that you don't want to use
            for _, name in pairs(no_format_servers) do
                if name == client.name then
                    return false
                end
            end
            return true
        end,
        bufnr = bufnr,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local lsp_format = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client)
    lsp_format(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- get a weird loop error with this
--[[ local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp") ]]
--[[ if status_ok then ]]
--[[     capabilities = cmp_nvim_lsp.default_capabilities() ]]
--[[ end ]]

--[[ local lsp_capabilities = {} ]]
--[[ local lsp_select_ok, lsp_selection_range = pcall(require, "lsp-selection-range") ]]
--[[ if lsp_select_ok then ]]
--[[     lsp_capabilities = lsp_selection_range.updaate_capabilites({}) ]]
--[[ end ]]

-- until https://github.com/neovim/neovim/pull/23500/files is merged
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
M.capabilities = capabilities

return M
