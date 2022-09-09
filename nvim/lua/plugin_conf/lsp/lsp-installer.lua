local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local lspconf_status, nvim_lsp = pcall(require, "lspconfig")
if not lspconf_status then
    return
end

local handlers_ok, my_handlers = pcall(require, "plugin_conf.lsp.handlers")
if not handlers_ok then
    return
end

lsp_installer.setup()

-- special setup for haskell, for some reason it crashes on certain files when used
-- with nvim lsp installer - could be due to outdated version
nvim_lsp.hls.setup({
    -- cmd = { "haskell-language-server-wrapper", "--lsp", "--debug" },
    settings = {
        haskell = {
            formattingProvider = "fourmolu",
        },
    },
    on_attach = my_handlers.on_attach,
    capabilities = my_handlers.capabilities,
})

nvim_lsp.sumneko_lua.setup({
    on_attach = my_handlers.on_attach,
    capabilities = my_handlers.capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "lua"] = true,
                },
            },
        },
    },
})

nvim_lsp.sqls.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        require("sqls").on_attach(client, bufnr)
        my_handlers.on_attach(client, bufnr)
    end,
})

local default_setup = {
    on_attach = my_handlers.on_attach,
    capabilities = my_handlers.capabilities,
}

nvim_lsp.terraformls.setup(default_setup)
nvim_lsp.bashls.setup(default_setup)
nvim_lsp.cssls.setup(default_setup)
nvim_lsp.dhall_lsp_server.setup(default_setup)
nvim_lsp.dockerls.setup({
    on_attach = my_handlers.on_attach,
    capabilities = my_handlers.capabilities,
    settings = {
        docker = {
            languageserver = {
                formatter = {
                    ignoreMultilineInstructions = true,
                },
            },
        },
    },
})
nvim_lsp.html.setup(default_setup)
nvim_lsp.jsonls.setup(default_setup)
nvim_lsp.pyright.setup(default_setup)
nvim_lsp.graphql.setup(default_setup)
nvim_lsp.rust_analyzer.setup(default_setup)
nvim_lsp.ocamllsp.setup(default_setup)
local ts_ok, ts = pcall(require, "typescript")
if ts_ok then
    ts.setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        disable_formatting = false, -- disable tsserver's formatting capabilities
        debug = false, -- enable debug logging for commands
        server = default_setup, -- pass options to lspconfig's setup method
    })
end
