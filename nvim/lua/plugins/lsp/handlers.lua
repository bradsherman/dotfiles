local methods = vim.lsp.protocol.Methods

local M = {}

local function lsp_highlight_document(client, bufnr)
    if client.supports_method(methods.textDocument_documentHighlight) then
        local under_cursor_highlights_group = vim.api.nvim_create_augroup("cursor_highlights", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave", "BufEnter" }, {
            group = under_cursor_highlights_group,
            desc = "Highlight references under the cursor",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
            group = under_cursor_highlights_group,
            desc = "Clear highlight references",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

local function diag_jump(bufnr, count)
    vim.diagnostic.jump({ count = count, float = true })
    -- require("tiny-inline-diagnostic").get_diagnostic_under_cursor(bufnr)
end

-- TODO: register these with which key instead
local function lsp_keymaps(client, bufnr)
    vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gR", "<cmd>FzfLua lsp_references<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gt", "<cmd>FzfLua lsp_type_defs<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gm", "<cmd>FzfLua lsp_document_symbols<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", { buffer = bufnr })
    -- vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<cr>", { buffer = bufnr })
    vim.keymap.set("n", "K", require("hover").hover, { buffer = bufnr })
    vim.keymap.set("n", "gK", require("hover").hover_select, { buffer = bufnr })
    vim.keymap.set("n", "<c-p>", function()
        diag_jump(bufnr, -1)
    end, { buffer = bufnr })
    vim.keymap.set("n", "<c-n>", function()
        diag_jump(bufnr, 1)
    end, { buffer = bufnr })
    -- vim.keymap.set("n", "<leader>lh", "<cmd>Lspsaga signature_help<CR>", { buffer = bufnr })
    -- vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>la", "<cmd>lua require('fastaction').code_action()<cr>", { buffer = bufnr })
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

local lsp_inlay_hints = function(client, bufnr)
    if client.supports_method(methods.textDocument_inlayHint) then
        local inlay_hints_group = vim.api.nvim_create_augroup("toggle_inlay_hints", { clear = false })

        -- Initial inlay hint display.
        -- Idk why but without the delay inlay hints aren't displayed at the very start.
        vim.defer_fn(function()
            local mode = vim.api.nvim_get_mode().mode
            vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr })
        end, 500)

        vim.api.nvim_create_autocmd("InsertEnter", {
            group = inlay_hints_group,
            desc = "Enable inlay hints",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
            end,
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
            group = inlay_hints_group,
            desc = "Disable inlay hints",
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end,
        })
    end
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(client, bufnr)
    lsp_highlight_document(client, bufnr)
    lsp_inlay_hints(client, bufnr)
end

local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("blink.cmp").get_lsp_capabilities()
    -- require("cmp_nvim_lsp").default_capabilities()
)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

M.capabilities = capabilities

return M
