local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local lspconf_status, nvim_lsp = pcall(require, "lspconfig")
if not lspconf_status then
    return
end

-- special setup for haskell, for some reason it crashes on certain files when used
-- with nvim lsp installer - could be due to outdated version
nvim_lsp.hls.setup({
    settings = {
        haskell = {
            formattingProvider = "fourmolu",
        },
    },
    on_attach = require("plugin_conf.lsp.handlers").on_attach,
    capabilities = require("plugin_conf.lsp.handlers").capabilities,
})

nvim_lsp.sqls.setup({
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        require("sqls").on_attach(client, bufnr)
    end,
})

nvim_lsp.terraform_lsp.setup({})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require("plugin_conf.lsp.handlers").on_attach,
        capabilities = require("plugin_conf.lsp.handlers").capabilities,
    }

    if server.name == "hls" then
        local hls_opts = require("plugin_conf.lsp.settings.hls")
        opts = vim.tbl_deep_extend("force", hls_opts, opts)
    end

    if server.name == "sumneko_lua" then
        local sumneko_opts = require("plugin_conf.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
