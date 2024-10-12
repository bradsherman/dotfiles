local elixir = require("elixir")
local elixirls = require("elixir.elixirls")

elixir.setup({
    -- TODO: figure out how to fix this
    nextls = { enable = false },
    credo = { enable = true },
    elixirls = {
        -- cmd = { vim.fn.expand("~/.local/bin/elixir-ls/language_server.sh") },
        enable = true,
        repo = "elixir-lsp/elixir-ls",
        settings = elixirls.settings({
            dialyzerEnabled = true,
            enableTestLenses = false,
        }),
        on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
            local handlers_ok, my_handlers = pcall(require, "plugins.lsp.handlers")
            if handlers_ok then
                my_handlers.on_attach(client, bufnr)
            end
        end,
    },
})
