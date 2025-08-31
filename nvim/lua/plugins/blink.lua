local source_priority = {
    snippets = 4,
    lsp = 3,
    path = 2,
    buffer = 1,
}

return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },

        -- use a release tag to download pre-built binaries
        version = "*",
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',
        config = function(_, opts)
            local blink = require("blink.cmp")
            blink.setup(opts)
            -- If we want, we can override the highlight group for the border
            -- vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "Pmenu" })
            -- vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "PmenuSel" })
        end,

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-e: Hide menu
            -- C-k: Toggle signature help
            --
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = {
                preset = "default",
                ["<C-h>"] = { "select_and_accept" },
                -- ["<CR>"] = { "accept", "fallback" },
                ["<C><leader>"] = { "show" },
            },

            completion = {
                -- Disable auto brackets
                -- NOTE: some LSPs may add auto brackets themselves anyway
                accept = { auto_brackets = { enabled = false } },
                menu = {
                    border = "single",
                    -- draw = {
                    --     components = {
                    --         kind_icon = {
                    --             ellipsis = false,
                    --             text = function(ctx)
                    --                 local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                    --                 return kind_icon
                    --             end,
                    --             -- Optionally, you may also use the highlights from mini.icons
                    --             highlight = function(ctx)
                    --                 local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                    --                 return hl
                    --             end,
                    --         },
                    --     },
                    -- },
                    --
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
                -- documentation = { window = { border = "single" } },
                -- Show documentation when selecting a completion item
                documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "single" } },

                -- Display a preview of the selected item on the current line
                ghost_text = { enabled = true },
            },

            signature = {
                enabled = true,
                window = { border = "single", show_documentation = false },
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { snippets = { score_offset = 4 }, "lsp", "path", "codecompanion", "buffer" },
                min_keyword_length = 3,
            },

            snippets = { preset = "luasnip" },

            -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
