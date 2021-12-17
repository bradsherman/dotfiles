local map = require("utils").map
local actions = require("telescope.actions")
local uReload = require("utils").reload
local print = require("utils").print

require("telescope").setup({
	defaults = {
		layout = { prompt_position = "bottom" },
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		mappings = {
			i = {
				["<c-j>"] = actions.move_selection_next,
				["<c-k>"] = actions.move_selection_previous,
				["<c-q>"] = actions.send_to_qflist,
			},
		},
	},
	pickers = {
		lsp_code_actions = { theme = "cursor" },
		lsp_workspace_symbols = { theme = "ivy" },
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			mappings = {
				i = {
					["<c-d>"] = "delete_buffer",
				},
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("hoogle")

local M = {}

function M.reload()
	-- Telescope will give us something like ju/colors.lua,
	-- so this function convert the selected entry to
	-- the module name: ju.colors
	local function get_module_name(s)
		local module_name

		module_name = s:gsub("%.lua", "")
		module_name = module_name:gsub("%/", ".")
		module_name = module_name:gsub("%.init", "")

		return module_name
	end

	local prompt_title = "~ neovim modules ~"

	-- sets the path to the lua folder
	local path = "~/.config/nvim/lua"

	local opts = {
		prompt_title = prompt_title,
		cwd = path,

		attach_mappings = function(_, m)
			-- Adds a new map to ctrl+e.
			m("i", "<c-e>", function(_)
				-- these two a very self-explanatory
				local entry = require("telescope.actions.state").get_selected_entry()
				local name = get_module_name(entry.value)

				-- call the helper method to reload the module
				-- and give some feedback
				uReload(name)
				print(name .. " RELOADED!!!")
			end)

			return true
		end,
	}

	-- call the builtin method to list files
	require("telescope.builtin").find_files(opts)
end

map("n", "<c-f>", "<cmd>Telescope find_files<cr>", { silent = true, noremap = true })
map("n", "<c-g>", "<cmd>Telescope live_grep<cr>", { silent = true, noremap = true })
map("n", "<c-t>", "<cmd>Telescope tags<cr>", { silent = true, noremap = true })
map("n", "<c-b>", "<cmd>Telescope buffers<cr>", { silent = true, noremap = true })
map("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", { silent = true, noremap = true })
map("n", "<leader>qr", '<cmd>:lua require("plugin_conf/telescope").reload()<cr>', { noremap = true, silent = true })

return M
