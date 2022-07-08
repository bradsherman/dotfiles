local file_exists = require("utils").file_exists

require("plugin_conf.git-nvim.gitsigns")
require("plugin_conf.git-nvim.conflict")
require("plugin_conf.git-nvim.worktree")

local gh_exists = file_exists("gh")
if not gh_exists then
    return
end
require("plugin_conf.git-nvim.octo")
require("plugin_conf.git-nvim.litee_gh")
