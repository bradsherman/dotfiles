local handlers_ok, my_handlers = pcall(require, "lsp")
if not handlers_ok then
    return
end
vim.g.haskell_tools = {
    hls = {
        on_attach = function(client, bufnr, ht)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
            vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
            -- vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, opts)
            -- Suggested keymaps that do not depend on haskell-language-server
            -- Toggle a GHCi repl for the current package
            vim.keymap.set("n", "<leader>rr", ht.repl.toggle, opts)
            -- Toggle a GHCi repl for the current buffer
            vim.keymap.set("n", "<leader>rf", function()
                ht.repl.toggle(vim.api.nvim_buf_get_name(0))
            end, opts)
            vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts)
            vim.keymap.set("n", "<leader>hs", "<cmd>HsPackageYaml<cr>", opts)
            vim.keymap.set("n", "<leader>hp", "<cmd>HsProjectFile<cr>", opts)
            ht.dap.discover_configurations(bufnr)
            my_handlers.on_attach(client, bufnr) -- if defined, see nvim-lspconfig
        end,
        capabilities = my_handlers.capabilities,
        settings = {
            haskell = {
                plugin = {
                    stan = { globalOn = false },
                    semanticTokens = { globalOn = true },
                },
            },
        },
    },
    tools = {
        codeLens = { autoRefresh = true },
        hoogle = { mode = "auto" },
        -- hover = {},
        definition = { hoogle_signature_fallback = true },
        repl = { handler = "toggleterm" },
        -- tags = {},
        -- log = {},
    },
}
