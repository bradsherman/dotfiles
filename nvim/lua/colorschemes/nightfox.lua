local status_ok, nightfox = pcall(require, "nightfox")
if not status_ok then
    return
end

local palletes = {
    -- nordfox = {
    --     fg1 = "#000000",
    -- },
}
nightfox.setup({
    options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = false, -- Disable setting background
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false, -- Non focused panes set to alternative background
        module_default = true, -- Default enable value for modules

        styles = {
            comments = "italic,bold", -- Style that is applied to comments: see `highlight-args` for options
            functions = "italic,bold", -- Style that is applied to functions: see `highlight-args` for options
            keywords = "bold", -- Style that is applied to keywords: see `highlight-args` for options
            strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
            variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
        },
        inverse = {
            match_paren = true, -- Enable/Disable inverse highlighting for match parens
            visual = true, -- Enable/Disable inverse highlighting for visual selection
            search = true, -- Enable/Disable inverse highlights for search highlights
        },
        modules = { -- List of various plugins and additional options
            cmp = true,
            fidget = false,
            gitsigns = true,
            lightspeed = true,
            lsp_saga = true,
            lsp_trouble = true,
            native_lsp = true,
            neogit = true,
            neotree = true,
            notify = true,
            nvimtree = true,
            telescope = true,
            treesitter = true,
            tsrainbow = true,
            whichkey = true,
        },
    },
    palettes = palletes,
})

-- setup must be called before loading
vim.cmd("colorscheme nightfox")

---@diagnostic disable-next-line: unused-local
local nordfox_palette = {
    bg0 = "#232831",
    bg1 = "#2e3440",
    bg2 = "#39404f",
    bg3 = "#444c5e",
    bg4 = "#5a657d",
    black = {
        base = "#3b4252",
        bright = "#465780",
        dim = "#353a45",
        light = false,
    },
    blue = {
        base = "#81a1c1",
        bright = "#8cafd2",
        dim = "#668aab",
        light = false,
    },
    comment = "#60728a",
    cyan = {
        base = "#88c0d0",
        bright = "#93ccdc",
        dim = "#69a7ba",
        light = false,
    },
    fg0 = "#c7cdd9",
    fg1 = "#cdcecf",
    fg2 = "#abb1bb",
    fg3 = "#7e8188",
    green = {
        base = "#a3be8c",
        bright = "#b1d196",
        dim = "#8aa872",
        light = false,
    },
    magenta = {
        base = "#b48ead",
        bright = "#c895bf",
        dim = "#9d7495",
        light = false,
    },
    meta = {
        light = false,
        name = "nordfox",
    },
    orange = {
        base = "#c9826b",
        bright = "#d89079",
        dim = "#b46950",
        light = false,
    },
    pink = {
        base = "#bf88bc",
        bright = "#d092ce",
        dim = "#a96ca5",
        light = false,
    },
    red = {
        base = "#bf616a",
        bright = "#d06f79",
        dim = "#a54e56",
        light = false,
    },
    sel0 = "#3e4a5b",
    sel1 = "#4f6074",
    white = {
        base = "#e5e9f0",
        bright = "#e7ecf4",
        dim = "#bbc3d4",
        light = false,
    },
    yellow = {
        base = "#ebcb8b",
        bright = "#f0d399",
        dim = "#d9b263",
        light = false,
    },
}
