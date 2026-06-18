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
            local luasnip = require("luasnip")

            luasnip.config.setup({ history = false })

            local haskell_snippets = require("haskell-snippets").all
            luasnip.add_snippets("haskell", haskell_snippets, { key = "haskell" })

            blink.setup(opts)

            require("luasnip.loaders.from_vscode").lazy_load()
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
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            -- customize the drawing of kind icons
                            kind_icon = {
                                text = function(ctx)
                                    -- default kind icon
                                    local icon = ctx.kind_icon
                                    -- if LSP source, check for color derived from documentation
                                    if ctx.item.source_name == "LSP" then
                                        local color_item = require("nvim-highlight-colors").format(
                                            ctx.item.documentation,
                                            { kind = ctx.kind }
                                        )
                                        if color_item and color_item.abbr ~= "" then
                                            icon = color_item.abbr
                                        end
                                    end
                                    return icon .. ctx.icon_gap
                                end,
                                highlight = function(ctx)
                                    -- default highlight group
                                    local highlight = "BlinkCmpKind" .. ctx.kind
                                    -- if LSP source, check for color derived from documentation
                                    if ctx.item.source_name == "LSP" then
                                        local color_item = require("nvim-highlight-colors").format(
                                            ctx.item.documentation,
                                            { kind = ctx.kind }
                                        )
                                        if color_item and color_item.abbr_hl_group then
                                            highlight = color_item.abbr_hl_group
                                        end
                                    end
                                    return highlight
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
            -- fun

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "snippets", "lsp", "path", "buffer" },
                min_keyword_length = 2,
            },

            snippets = { preset = "luasnip" },

            -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = {
                -- sorts = {
                --     function(a, b)
                --         local source_priority = {
                --             snippets = 4,
                --             lsp = 3,
                --             path = 2,
                --             buffer = 1,
                --         }
                --
                --         local a_priority = source_priority[a.source_id]
                --         local b_priority = source_priority[b.source_id]
                --         if a_priority ~= b_priority then
                --             return a_priority > b_priority
                --         end
                --     end,
                --     -- defaults
                --     "score",
                --     "sort_text",
                -- },
                implementation = "prefer_rust_with_warning",
            },
        },
        opts_extend = { "sources.default" },
    },
}
