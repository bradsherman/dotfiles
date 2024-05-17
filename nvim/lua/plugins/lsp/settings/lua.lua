return {
    Lua = {
        runtime = {
            version = "LuaJIT",
        },
        diagnostics = {
            globals = { "vim" },
        },
        workspace = {
            checkThirdParty = false,
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "lua"] = true,
                ["/usr/share/nvim/runtime/lua"] = true,
                ["/usr/share/nvim/runtime/lua/vim"] = true,
                ["/usr/share/nvim/runtime/lua/vim/lsp"] = true,
            },
        },
        telemetry = {
            enable = false,
        },
    },
}
