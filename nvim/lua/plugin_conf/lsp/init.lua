local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("plugin_conf.lsp.lsp-installer")
require("plugin_conf.lsp.handlers").setup()
require("plugin_conf.lsp.null-ls")
