vim.opt.background = "dark"
vim.opt.termguicolors = true

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

local palletes = {
    -- nordfox = {
    --     fg1 = "#000000",
    -- },
}

nightfox.setup({
    options = {
        transparent = false, -- Disable setting the background color
        dim_inactive = false, -- Non current window bg to alt color see `hl-NormalNC`
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
        modules = {
            cmp = true,
            fidget = true,
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
    pallete = palletes,
})

-- Load the configuration set above and apply the colorscheme
vim.cmd("colorscheme nordfox")
