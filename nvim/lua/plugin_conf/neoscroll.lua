require("neoscroll").setup({
	mappings = { "<C-u>", "<C-d>" },
	stop_eof = false,
	hide_cursor = false,
	-- Set any other options as needed
})
local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "250", "sine" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "250", "sine" } }
require("neoscroll.config").set_mappings(t)
