local status_ok, impatient = pcall(require, "impatient")
if status_ok then
    impatient.enable_profile()
end

local function safe_load(plugin)
    local ok, p = pcall(require, plugin)
    if ok then
        p.setup()
    end
end

-- easy installs
safe_load("pqf")
safe_load("nvim-web-devicons")
safe_load("stabilize")
safe_load("renamer")
safe_load("inc_rename")
safe_load("nvim-ts-autotag")
safe_load("window_picker")

require("plugin_conf.litee")
require("plugin_conf.tree")
require("plugin_conf.neogit")
require("plugin_conf.neoscroll")
require("plugin_conf.todo")
require("plugin_conf.lualine")
require("plugin_conf.telescope")
require("plugin_conf.trouble")
require("plugin_conf.treesitter")
require("plugin_conf.lspsaga")
require("plugin_conf.lsp")
require("plugin_conf.dbg")
require("plugin_conf.cmp")
require("plugin_conf.git-nvim")
require("plugin_conf.neorg")
require("plugin_conf.indent_blankline")
require("plugin_conf.which_key")
require("plugin_conf.bufferline")
require("plugin_conf.comment")
require("plugin_conf.toggleterm")
require("plugin_conf.zen")
require("plugin_conf.twilight")
require("plugin_conf.autopairs")
require("plugin_conf.symbols")
require("plugin_conf.beacon")
require("plugin_conf.react_extract")
require("plugin_conf.dressing")
require("plugin_conf.colorizer")
require("plugin_conf.harpoon")
-- require("plugin_conf.notify")
require("plugin_conf.fidget")
require("plugin_conf.dim")
-- require("plugin_conf.alpha")

vim.g.do_filetype_lua = 1

vim.keymap.set("n", "<leader>tm", ":TableModeToggle<cr>")
vim.keymap.set("n", "<leader>dfo", ":DiffviewOpen<cr>")
vim.keymap.set("n", "<leader>dfc", ":DiffviewClose<cr>")
vim.keymap.set("n", "<leader>hw", ":HopWord<cr>")

local file_exists = require("utils").file_exists

local glow_exists = file_exists("glow")
local glow_status_ok, glow_hover = pcall(require, "glow-hover")
if not glow_status_ok or not glow_exists then
    return
end

glow_hover.setup({
    -- The followings are the default values
    max_width = 50,
    padding = 10,
    border = "shadow",
    glow_path = "glow",
})
