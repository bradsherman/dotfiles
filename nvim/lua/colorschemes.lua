vim.opt.background = "dark"
-- not sure if this is correct, but colors seem to work
if vim.opt.termguicolors then
    vim.opt.termguicolors = true
end

-- To enable transparency
-- if vim.fn.has("gui_running") == 0 then
-- 	vim.g.solarized_termtrans = 0
-- else
-- 	vim.g.solarized_termtrans = 1
-- end
-- vim.g.solarized_italics = 1
-- vim.g.solarized_visbility = "normal"
-- vim.cmd("colorscheme solarized-flat")

-- vim.cmd("colorscheme zenbones")
-- vim.cmd("colorscheme tokyonight")

local nfox_status_ok, nightfox = pcall(require, "nightfox")
if not nfox_status_ok then
    return
end

nightfox.setup({
    fox = "nordfox", -- change the colorscheme to use nordfox
    transparent = false, -- Disable setting the background color
    alt_nc = false, -- Non current window bg to alt color see `hl-NormalNC`
    terminal_colors = true, -- Configure the colors used when opening :terminal
    styles = {
        comments = "italic", -- Style that is applied to comments: see `highlight-args` for options
        functions = "italic,bold", -- Style that is applied to functions: see `highlight-args` for options
        keywords = "bold", -- Style that is applied to keywords: see `highlight-args` for options
        strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
        variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
    },
    inverse = {
        match_paren = true, -- Enable/Disable inverse highlighting for match parens
        visual = false, -- Enable/Disable inverse highlighting for visual selection
        search = false, -- Enable/Disable inverse highlights for search highlights
    },
    colors = {
        red = "#FF000", -- Override the red color for MAX POWER
        bg_alt = "#000000",
    },
    hlgroups = {
        TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
        LspCodeLens = { bg = "#000000", style = "italic" },
    },
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
