require("vim._core.ui2").enable({})

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

vim.cmd("colorscheme kanagawa-wave")
