local config = {
    -- show signs
    signs = {
        { name = "DiagnosticSignError", text = " " },
        { name = "DiagnosticSignWarn", text = " " },
        { name = "DiagnosticSignHint", text = " " },
        { name = "DiagnosticSignInfo", text = " " },
    },
    root_markes = { ".git" },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        enabled = false,
        header = "",
        prefix = "",
    },
}
vim.diagnostic.config(config)

vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

local function diag_jump(_, count)
    vim.diagnostic.jump({ count = count, float = false })
    require("tiny-inline-diagnostic").get_diagnostic_under_cursor()
end

local function lsp_keymaps(client, bufnr)
    vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gR", "<cmd>FzfLua lsp_references<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gt", "<cmd>FzfLua lsp_type_defs<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gm", "<cmd>FzfLua lsp_document_symbols<cr>", { buffer = bufnr })
    vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", { buffer = bufnr })
    vim.keymap.set("n", "K", require("hover").open, { buffer = bufnr })
    vim.keymap.set("n", "gK", require("hover").select, { buffer = bufnr })
    vim.keymap.set("n", "<c-p>", function()
        diag_jump(bufnr, -1)
    end, { buffer = bufnr })
    vim.keymap.set("n", "<c-n>", function()
        diag_jump(bufnr, 1)
    end, { buffer = bufnr })
    vim.keymap.set("n", "<leader>la", "<cmd>lua require('fastaction').code_action()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_workspace_symbols<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<space>lr", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { buffer = bufnr, expr = true })
    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.document_formatting then
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr, async = true })
    end
    if client.server_capabilities.document_range_formatting then
        vim.keymap.set("v", "<leader>cf", vim.lsp.buf.range_format, { buffer = bufnr, async = true })
    end
end

local function lsp_highlight_document(client, bufnr)
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("brad.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        lsp_keymaps(client, args.buf)
        lsp_highlight_document(client, args.buf)
    end,
})

vim.api.nvim_create_user_command("LspReload", function()
    vim.lsp.stop_client(vim.lsp.get_clients())
    vim.api.nvim_command([[ edit ]])
end, {
    desc = "Reload all LSPs",
})
