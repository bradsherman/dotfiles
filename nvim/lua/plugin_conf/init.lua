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
safe_load("nvim-web-devicons")
safe_load("inc_rename")
safe_load("nvim-ts-autotag")
safe_load("window_picker")

require("plugin_conf.lspsaga")
require("plugin_conf.modes")
require("plugin_conf.bqf")
require("plugin_conf.litee")
require("plugin_conf.window_picker")
require("plugin_conf.tree")
require("plugin_conf.neogit")
require("plugin_conf.neoscroll")
require("plugin_conf.todo")
require("plugin_conf.lualine")
require("plugin_conf.telescope")
require("plugin_conf.trouble")
require("plugin_conf.treesitter")
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
require("plugin_conf.dressing")
require("plugin_conf.colorizer")
require("plugin_conf.harpoon")
require("plugin_conf.notify")
require("plugin_conf.neodim")
require("plugin_conf.surround")
require("plugin_conf.folds")
require("plugin_conf.windows")
require("plugin_conf.winsep")
require("plugin_conf.smart_splits")
require("plugin_conf.fidget")
require("plugin_conf.headlines")
require("plugin_conf.sad")
require("plugin_conf.statuscol")
--[[ require("plugin_conf.murmur") ]]
--[[ require("plugin_conf.noice") ]]
--[[ require("plugin_conf.yanky") ]]
--[[ require("plugin_conf.scrollbar") ]]
