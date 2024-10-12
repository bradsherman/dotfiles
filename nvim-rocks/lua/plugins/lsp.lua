local config = {
    virtual_text = false,
    -- virtual_text = {
    --     source = "always",
    --     spacing = 4,
    --     prefix = "●",
    --     -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    --     -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
    --     -- prefix = "icons",
    -- },
    -- show signs
    sign = true,
    signs = {

        { name = "DiagnosticSignError", text = " " },
        { name = "DiagnosticSignWarn", text = " " },
        { name = "DiagnosticSignHint", text = " " },
        { name = "DiagnosticSignInfo", text = " " },
    },
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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

vim.diagnostic.config(config)

vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require("lspconfig")[ls].setup({
        capabilities = capabilities,
        -- you can add other fields for setting up lsp server in this table
    })
end

require("mason").setup()
local mason_lsp = require("mason-lspconfig")

local opts = {
    ensure_installed = {
        "bashls",
        "dhall_lsp_server",
        "dockerls",
        -- "elixirls",
        -- "nextls",
        -- "html",
        --[[ "hls", ]]
        "jsonls",
        "lua_ls",
        "nil_ls",
        "ocamllsp",
        -- "pylsp",
        "rust_analyzer",
        "tailwindcss",
        "taplo",
        "terraformls",
        "tflint",
        --[[ "tsserver", ]]
        "v_analyzer",
        "yamlls",
        "zls",
    },
}
mason_lsp.setup(opts)
local nvim_lsp = require("lspconfig")

local handlers_ok, my_handlers = pcall(require, "plugins.lsp.handlers")
-- if not handlers_ok then
--     return
-- end

local default_setup = {
    on_attach = my_handlers.on_attach,
    capabilities = my_handlers.capabilities,
}

mason_lsp.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        nvim_lsp[server_name].setup(default_setup)
    end,
    ["lua_ls"] = function()
        local settings_ok, lua_settings = pcall(require, "plugins.lsp.settings.lua")
        if not settings_ok then
            return
        end
        nvim_lsp.lua_ls.setup({
            settings = lua_settings,
            on_attach = my_handlers.on_attach,
            capabilities = my_handlers.capabilities,
        })
    end,
    -- ["sqls"] = function()
    --     nvim_lsp.sqls.setup({
    --         on_attach = function(client, bufnr)
    --             client.server_capabilities.document_formatting = false
    --             client.server_capabilities.document_range_formatting = false
    --             require("sqls").on_attach(client, bufnr)
    --             my_handlers.on_attach(client, bufnr)
    --         end,
    --         capabilities = my_handlers.capabilities,
    --     })
    -- end,
    ["tailwindcss"] = function()
        nvim_lsp.tailwindcss.setup({
            capabilities = my_handlers.capabilities,
            on_attach = my_handlers.on_attach,
            filetypes = { "html", "elixir", "eelixir", "heex" },
            root_dir = nvim_lsp.util.root_pattern(
                "tailwind.config.{js,cjs,mjs,ts}",
                "assets/tailwind.config.{js,cjs,mjs,ts}"
            ),
            init_options = {
                userLanguages = {
                    elixir = "html-eex",
                    eelixir = "html-eex",
                    heex = "html-eex",
                },
            },
            settings = {
                tailwindCSS = {
                    experimental = {
                        classRegex = {
                            'class[:]\\s*"([^"]*)"',
                        },
                    },
                },
            },
        })
    end,
})
