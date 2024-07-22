return {
    {
        "zaldih/themery.nvim",
        enabled = true,
        config = function()
            -- Minimal config
            require("themery").setup({
                themes = {
                    {
                        colorscheme = "kanagawa-wave",
                        name = "Kanagawa Wave",
                        before = [[vim.opt.background = "dark"]],
                    },
                    {
                        colorscheme = "kanagawa-dragon",
                        name = "Kanagawa Dragon",
                        before = [[vim.opt.background = "dark"]],
                    },
                    {
                        colorscheme = "kanagawa-lotus",
                        name = "Kanagawa Lotus",
                        before = [[vim.opt.background = "light"]],
                    },
                    {
                        colorscheme = "bamboo",
                        name = "Bamboo",
                        before = [[vim.opt.background = "dark"]],
                    },
                    {
                        colorscheme = "bamboo",
                        name = "Bamboo Light",
                        before = [[vim.opt.background = "light"]],
                    },
                    {
                        colorscheme = "onenord",
                        name = "OneNord",
                        before = [[vim.opt.background = "dark"]],
                    },
                    {
                        colorscheme = "solarized-high",
                        name = "Solarized Light",
                        before = [[vim.opt.background = "light"]],
                    },
                },
                themeConfigFile = "~/.config/nvim/lua/theme.lua", -- Described below
                livePreview = true, -- Apply theme while browsing. Default to true.
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        config = function(_, opts)
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
            require("kanagawa").setup(opts)
            vim.cmd([[ colorscheme kanagawa-dragon ]])
        end,
        lazy = false,
        priority = 1000,
        opts = {
            compile = true, -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = false },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = true, -- do not set background color
            dimInactive = true, -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = { -- add/modify theme and palette colors
                palette = {},
                theme = {
                    wave = {},
                    lotus = {},
                    dragon = {},
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                    -- dark completion popup menu
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },

                    -- block telescope?
                    TelescopeTitle = { fg = theme.ui.special, bold = true, blend = vim.o.pumblend },
                    TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                    TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                }
            end,
            -- theme = "lotus", -- "wave", "dragon", "lotus"
            background = { -- map the value of 'background' option to a theme
                dark = "dragon", -- try "dragon" !
                light = "lotus",
            },
        },
    },
    { "EdenEast/nightfox.nvim", lazy = true },
    { "folke/tokyonight.nvim", lazy = true },
    {
        "ishan9299/nvim-solarized-lua",
        lazy = true,
        config = function()
            vim.opt.background = "light"
            vim.cmd("colorscheme solarized-high")
        end,
    },
    {
        "rmehri01/onenord.nvim",
        lazy = true,
        config = function()
            require("onenord").setup({
                theme = nil, -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
                borders = true, -- Split window borders
                fade_nc = false, -- Fade non-current windows, making them more distinguishable
                -- Style that is applied to various groups: see `highlight-args` for options
                styles = {
                    comments = "NONE",
                    strings = "NONE",
                    keywords = "NONE",
                    functions = "NONE",
                    variables = "NONE",
                    diagnostics = "underline",
                },
                disable = {
                    background = false, -- Disable setting the background color
                    float_background = false, -- Disable setting the background color for floating windows
                    cursorline = false, -- Disable the cursorline
                    eob_lines = true, -- Hide the end-of-buffer lines
                },
                -- Inverse highlight for different groups
                inverse = {
                    match_paren = false,
                },
                custom_highlights = {}, -- Overwrite default highlight groups
                custom_colors = {}, -- Overwrite default colors
            })
        end,
    },
    {
        "ribru17/bamboo.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
            require("bamboo").setup({
                -- optional configuration here
            })
            require("bamboo").load()
            vim.cmd([[ colorscheme bamboo ]])
        end,
    },
    { "loctvl842/monokai-pro.nvim", lazy = true },
    {
        "phha/zenburn.nvim",
        config = function(_, opts)
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
            require("zenburn").setup(opts)
            vim.cmd([[ colorscheme zenburn ]])
        end,
        lazy = true,
        priority = 1000,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        priority = 1000,
        config = function(_, opts)
            vim.opt.background = "dark"
            vim.opt.termguicolors = true
            require("rose-pine").setup(opts)
            vim.cmd([[ colorscheme rose-pine ]])
        end,
    },
    {
        "rachartier/tiny-devicons-auto-colors.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = "VeryLazy",
        config = function()
            local colors = require("kanagawa.colors").setup()
            local palette_colors = colors.palette
            -- local theme_colors = colors.theme
            require("tiny-devicons-auto-colors").setup({ colors = palette_colors })
        end,
    },
}
