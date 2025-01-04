return {
    "Jezda1337/nvim-html-css", -- add it as dependencies of `nvim-cmp` or standalone plugin
    enabled = false,
    opts = {
        sources = {
            {
                name = "html-css",
                option = {
                    enable_on = { "html" }, -- html is enabled by default
                    notify = false,
                    documentation = {
                        auto_show = true, -- show documentation on select
                    },
                },
            },
        },
    },
}
