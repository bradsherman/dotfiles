return {
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "mrcjkb/haskell-snippets.nvim",
            "saadparwaiz1/cmp_luasnip",
        },
    },
    "R-nvim/cmp-r",
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-cmdline",
            "ray-x/cmp-treesitter",
            "quangnguyen30192/cmp-nvim-tags",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "windwp/nvim-autopairs",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "L3MON4D3/LuaSnip",
            {
                {
                    "MattiasMTS/cmp-dbee",
                    dependencies = {
                        { "kndndrj/nvim-dbee" },
                    },
                    ft = "sql", -- optional but good to have
                    opts = {}, -- needed
                },
            },
            "luckasRanarison/tailwind-tools.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            luasnip.config.setup({ history = false })

            local haskell_snippets = require("haskell-snippets").all
            luasnip.add_snippets("haskell", haskell_snippets, { key = "haskell" })

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local window_ops = cmp.config.window.bordered()
            window_ops.border = "rounded" -- default

            local kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            }

            cmp.setup({
                -- completion = {
                --     keyword_length = 2,
                -- },
                view = {
                    entries = {
                        follow_cursor = true,
                    },
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = window_ops,
                    -- completion = {
                    --     winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    --     col_offset = -3,
                    --     side_padding = 0,
                    -- },
                    documentation = window_ops,
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        if vim.tbl_contains({ "path" }, entry.source.name) then
                            local icon, hl_group =
                                require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                            if icon then
                                vim_item.kind = icon
                                vim_item.kind_hl_group = hl_group
                                return vim_item
                            end
                        end

                        -- Kind icons
                        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                        -- Source
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        })[entry.source.name]

                        vim_item.before = require("tailwind-tools.cmp").lspkind_format

                        return vim_item
                    end,
                },
                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item({ "i", "c" }),
                    ["<C-n>"] = cmp.mapping.select_next_item({ "i", "c" }),
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "cmp-dbee" },
                    { name = "neorg" },
                    { name = "cmp_r" },
                    { name = "treesitter" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "tags" },
                    { name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
                }, {
                    { name = "buffer" },
                }),
                experimental = {
                    ghost_text = true,
                },
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "buffer" },
                }),
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                    { name = "buffer" },
                }),
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })

            require("cmp_r").setup({})

            -- Nvim autopairs
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local ts_utils = require("nvim-treesitter.ts_utils")

            local ts_node_func_parens_disabled = {
                -- ecma
                named_imports = true,
                -- rust
                use_declaration = true,
            }

            local default_handler = cmp_autopairs.filetypes["*"]["("].handler
            cmp_autopairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
                local node_type = ts_utils.get_node_at_cursor():type()
                if ts_node_func_parens_disabled[node_type] then
                    if item.data then
                        item.data.funcParensDisabled = true
                    else
                        char = ""
                    end
                end
                default_handler(char, item, bufnr, rules, commit_character)
            end

            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done({
                    sh = false,
                })
            )

            -- this loads friendly snippets
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
