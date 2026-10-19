require("which-key").setup({
	preset = "modern",
})

require("oil").setup({
	-- Skip the confirmation popup for simple operations
	skip_confirm_for_simple_edits = true,
	-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
	prompt_save_on_select_new_entry = true,
	-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
	-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
	-- Additionally, if it is a string that matches "actions.<name>",
	-- it will use the mapping at require("oil.actions").<name>
	-- Set to `false` to remove a keymap
	-- See :help oil-actions for a list of all available actions
	keymaps = {
		["l"] = "actions.select",

		["<C-s>"] = false,
		["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },

		["<C-h>"] = {
			"actions.select",
			opts = { horizontal = true },
			desc = "Open the entry in a horizontal split",
		},
		["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },

		["<C-l>"] = false,
		["<C-r>"] = "actions.refresh",

		["h"] = "actions.parent",
	},
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
		-- This function defines what will never be shown, even when `show_hidden` is set
		is_always_hidden = function(name, bufnr)
			return vim.endswith(name, ".hie") or name == ".." or name == ".git"
		end,
	},
})

require("fzf-lua").setup({
	{ "ivy", "borderless-full" },
	keymap = {
		fzf = {
			["ctrl-q"] = "select-all+accept",
		},
	},
	-- rg/fd only honor .gitignore when they detect a `.git` dir. jj repos are
	-- not colocated here, so without --no-require-git every picker walks
	-- node_modules/dist/etc. Otherwise these match the fzf-lua defaults.
	files = {
		fd_opts = [[--color=never --type f --type l --exclude .git --exclude .jj --no-require-git]],
		rg_opts = [[--color=never --files -g "!.git" -g "!.jj" --no-require-git]],
	},
	grep = {
		rg_opts = [[--column --line-number --no-heading --color=always --smart-case ]]
			.. [[--max-columns=4096 --no-require-git -g "!.git" -g "!.jj" -e]],
	},
})
