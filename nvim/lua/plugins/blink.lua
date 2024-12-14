return {
    { "saghen/blink.compat", enabled = false, version = "*" },
    -- {
    --     "L3MON4D3/LuaSnip",
    --     enabled = true,
    --     build = "make install_jsregexp",
    --     dependencies = {
    --         "rafamadriz/friendly-snippets",
    --         "mrcjkb/haskell-snippets.nvim",
    --         "saadparwaiz1/cmp_luasnip",
    --     },
    -- },
    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        enabled = false,
        -- optional: provides snippets for the snippet source
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "mrcjkb/haskell-snippets.nvim",
            "rafamadriz/friendly-snippets",
        },

        -- use a release tag to download pre-built binaries
        version = "v0.*",
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = { preset = "super-tab" },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                completion = {
                    enabled_providers = { "lsp", "path", "luasnip", "snippets", "buffer" },
                },
                providers = {
                    luasnip = {
                        name = "luasnip",
                        module = "blink.compat.source",

                        score_offset = -3,

                        opts = {
                            use_show_condition = false,
                            show_autosnippets = true,
                        },
                    },
                },
            },
            snippets = {
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },

            -- experimental auto-brackets support
            -- completion = { accept = { auto_brackets = { enabled = true } } }

            -- experimental signature help support
            -- signature = { enabled = true }
        },
        -- allows extending the enabled_providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.completion.enabled_providers" },
    },
}
