local M = {}

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "❌" },
        { name = "DiagnosticSignWarn", text = "⚠️ " },
        { name = "DiagnosticSignHint", text = "💡" },
        { name = "DiagnosticSignInfo", text = "ℹ️ " },
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

local function lsp_keymaps(client, bufnr)
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gm", "<cmd>Telescope lsp_document_symbols<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gD", "<cmd>Lspsaga preview_definition<cr>", { buffer = bufnr })
    -- vim.keymap.set("n", "<leader>lt", "<cmd>LspTroubleToggle<cr>", { buffer = bufnr })
    -- vim.keymap.set("n", "<leader>ltr", "<cmd>LspTroubleRefresh<cr>", { buffer = bufnr })
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>lh", "<cmd>Lspsaga signature_help<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_workspace_symbols<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<space>le", "<cmd>Lspsaga show_line_diagnostics<CR>", { buffer = bufnr })
    vim.keymap.set("n", "<space>lr", function()
        require("renamer").rename()
    end, { buffer = bufnr })
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.document_formatting then
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, async = true })
    end
    if client.server_capabilities.document_range_formatting then
        vim.keymap.set("v", "<leader>cf", vim.lsp.buf.range_format, { buffer = bufnr, async = true })
    end
end

local no_format_servers = { "tsserver", "sumneko_lua", "sqls", "dockerls" }

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(clients)
            -- filter out clients that you don't want to use
            return vim.tbl_filter(function(client)
                for _, v in ipairs(no_format_servers) do
                    if v == client.name then
                        return false
                    end
                end
                return true
            end, clients)
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

local lsp_sig_ok, lsp_sig = pcall(require, "lsp_signature")

M.on_attach = function(client, bufnr)
    if lsp_sig_ok then
        lsp_sig.on_attach()
    end

    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client)
    lsp_format(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
    M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

return M
