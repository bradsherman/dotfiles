local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = true,
    sources = {
        -- diagnostics.eslint_d,
        diagnostics.selene,
        formatting.nixfmt,
        formatting.fourmolu,
        formatting.stylua,
        -- TODO: this needs to use prettier with eslint
        formatting.prettier.with({
            disabled_filetypes = { "html", "json", "yaml", "markdown" },
        }),
    },
    on_attach = require("plugin_conf.lsp.handlers").on_attach,
})
