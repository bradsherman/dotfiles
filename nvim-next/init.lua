require("options")
require("keybindings")
require("autocommands")

vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

vim.cmd("colorscheme kanagawa-wave")

vim.opt.completeopt = "menu,menuone,noselect,popup" -- Ensures the menu appears even for a single match and uses the native popup window.
vim.o.autocomplete = true -- Enables the overall completion feature.

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
	callback = function(args)
		local client_id = args.data.client_id
		if not client_id then
			return
		end

		local client = vim.lsp.get_client_by_id(client_id)
		if client and client:supports_method("textDocument/completion") then
			-- Enable native LSP completion for this client + buffer
			vim.lsp.completion.enable(true, client_id, args.buf, {
				autotrigger = true, -- auto-show menu as you type (recommended)
				-- You can also set { autotrigger = false } and trigger manually with <C-x><C-o>
			})
		end
	end,
})

require("vim._core.ui2").enable({})

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
})

require("nvim-web-devicons").setup({
	-- your personnal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh",
		},
		norg = {
			icon = "◉ ",
			color = "#4878BE",
			name = "Neorg",
		},
		oil = {
			icon = "󰏇 ",
			color = "#24283b",
			name = "oil",
		},
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true,
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
	-- globally enable "strict" selection of icons - icon will be looked up in
	-- different tables, first by filename, and if not found by extension; this
	-- prevents cases when file doesn't have any extension but still gets some icon
	-- because its name happened to match some extension (default to false)
	strict = true,
	-- same as `override` but specifically for overrides by filename
	-- takes effect when `strict` is true
	override_by_filename = {
		[".gitignore"] = {
			icon = "",
			color = "#f1502f",
			name = "Gitignore",
		},
	},
	-- same as `override` but specifically for overrides by extension
	-- takes effect when `strict` is true
	override_by_extension = {
		["log"] = {
			icon = "",
			color = "#81e043",
			name = "Log",
		},
		["hcl"] = {
			icon = " ",
			color = "#5F43E9",
			name = "HCL",
		},
	},
})

require("kanagawa").setup({
	compile = true, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = false },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = false, -- do not set background color
	dimInactive = true, -- dim inactive window `:h hl-NormalNC`
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	colors = { -- add/modify theme and palette colors
		palette = {},
		theme = {
			wave = {},
			lotus = {},
			dragon = {},
			all = {
				ui = {
					-- bg_gutter = "none",
				},
			},
		},
	},
	overrides = function(colors)
		local theme = colors.theme
		local makeDiagnosticColor = function(color)
			local c = require("kanagawa.lib.color")
			return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
		end

		return {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },

			-- Save an hlgroup with dark background and dimmed foreground
			-- so that you can use it where your still want darker windows.
			-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

			-- Popular plugins that open floats will link to NormalFloat by default;
			-- set their background accordingly if you wish to keep them dark and borderless
			LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
			MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

			-- dark completion popup menu
			Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
			PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = theme.ui.bg_p2 },

			-- block telescope?
			TelescopeTitle = { fg = theme.ui.special, bold = true, blend = vim.o.pumblend },
			TelescopePromptNormal = { bg = theme.ui.bg_p1 },
			TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
			TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
			TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
			TelescopePreviewNormal = { bg = theme.ui.bg_dim },
			TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

			-- Imitate diagnostic message style from tokyonight
			DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
			DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
			DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
			DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
			-- -- update kanagawa to handle new treesitter highlight captures
			-- ["@string.regexp"] = { link = "@string.regex" },
			-- ["@variable.parameter"] = { link = "@parameter" },
			-- ["@exception"] = { link = "@exception" },
			-- ["@string.special.symbol"] = { link = "@symbol" },
			-- ["@markup.strong"] = { link = "@text.strong" },
			-- ["@markup.italic"] = { link = "@text.emphasis" },
			-- ["@markup.heading"] = { link = "@text.title" },
			-- ["@markup.raw"] = { link = "@text.literal" },
			-- ["@markup.quote"] = { link = "@text.quote" },
			-- ["@markup.math"] = { link = "@text.math" },
			-- ["@markup.environment"] = { link = "@text.environment" },
			-- ["@markup.environment.name"] = { link = "@text.environment.name" },
			-- ["@markup.link.url"] = { link = "Special" },
			-- ["@markup.link.label"] = { link = "Identifier" },
			-- ["@comment.note"] = { link = "@text.note" },
			-- ["@comment.warning"] = { link = "@text.warning" },
			-- ["@comment.danger"] = { link = "@text.danger" },
			-- ["@diff.plus"] = { link = "@text.diff.add" },
			-- ["@diff.minus"] = { link = "@text.diff.delete" },
			-- ["@comment.todo"] = { link = "@text.todo" },
		}
	end,
	-- theme = "lotus", -- "wave", "dragon", "lotus"
	background = { -- map the value of 'background' option to a theme
		dark = "wave", -- try "dragon" !
		light = "lotus",
	},
})

local web_formatters = { "biome", "biome-check", "biome-orgaize-imports" }
local opts = {
	-- logging = true,
	-- log_level = vim.log.levels.DEBUG,
	formatters_by_ft = {
		lua = { "stylua" },
		hcl = { "hcl" },
		json = { "jq" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = web_formatters,
		typescript = web_formatters,
		javascriptreact = web_formatters,
		typescriptreact = web_formatters,
		sql = { "sqlfluff" },
		terraform = { "terraform_fmt" },
		nix = { "nixfmt" },
		haskell = { "fourmolu" },
		["*"] = { "trim_whitespace", "trim_newlines" },
	},
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 2000, lsp_fallback = true, lsp_format = "fallback" }
	end,
}
local opts_with_fourmolu = {
	formatters = {
		fourmolu = {
			-- This can be a string or a function that returns a string
			command = "fourmolu",
			-- OPTIONAL - all fields below this are optional
			-- A list of strings, or a function that returns a list of strings
			args = { "--stdin-input-file", "$FILENAME" },
			-- If the formatter supports range formatting, create the range arguments here
			range_args = function(ctx)
				return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
			end,
			-- Send file contents to stdin, read new contents from stdout (default true)
			-- When false, will create a temp file (will appear in "$FILENAME" args). The temp
			-- file is assumed to be modified in-place by the format command.
			stdin = true,
			-- A function that calculates the directory to run the command in
			cwd = require("conform.util").root_file({ "stack.yaml", "fourmolu.yaml" }),
			-- When cwd is not found, don't run the formatter (default false)
			require_cwd = true,
		},
	},
}
local full_opts = vim.tbl_deep_extend("force", opts, opts_with_fourmolu)

require("conform").setup(full_opts)
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

require("conform").formatters.injected = {
	-- Set the options field
	options = {
		-- Set individual option values
		ignore_errors = true,
		lang_to_formatters = {
			json = { "jq" },
		},
	},
}
