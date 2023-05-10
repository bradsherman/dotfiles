local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("plugin_conf.lsp.lsp-installer")
require("plugin_conf.lsp.handlers").setup()
require("plugin_conf.lsp.null-ls")

--[[ local lines_status_ok, lsp_lines = pcall(require, "lsp_lines") ]]
--[[ if lines_status_ok then ]]
--[[     lsp_lines.setup() ]]
--[[ end ]]
