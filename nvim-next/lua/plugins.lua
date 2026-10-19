-- Setup for plugins ported from the full `nvim` config, adapted for nvim-next's
-- minimalist / native approach. Plugin SOURCES are declared in init.lua's
-- vim.pack.add() call; this file only configures them.

local map = vim.keymap.set

--------------------------------------------------------------------------------
-- Treesitter (main branch): install parsers + enable highlighting.
-- nvim-next added nvim-treesitter to the pack list but never installed/started
-- it; textobjects below need the parsers, so wire it up here.
--------------------------------------------------------------------------------
do
	local ok, ts = pcall(require, "nvim-treesitter")
	if ok then
		local languages = {
			"bash", "c", "diff", "git_rebase", "gitcommit", "haskell", "hcl",
			"javascript", "json", "lua", "luadoc", "markdown", "markdown_inline",
			"nix", "python", "query", "sql", "terraform", "toml", "tsx",
			"typescript", "vim", "vimdoc", "yaml",
		}
		-- nvim-treesitter `main` compiles parsers with the `tree-sitter` CLI.
		-- Without it, install() errors for every language, so guard on it.
		if vim.fn.executable("tree-sitter") == 1 then
			local installed = ts.get_installed()
			local to_install = vim.tbl_filter(function(lang)
				return not vim.list_contains(installed, lang)
			end, languages)
			if #to_install > 0 then
				ts.install(to_install)
			end
		else
			vim.schedule(function()
				vim.notify(
					"[nvim-next] treesitter highlighting/textobjects need the `tree-sitter` CLI: brew install tree-sitter",
					vim.log.levels.WARN
				)
			end)
		end
		-- Enable TS highlighting per buffer (no-op for filetypes without a parser).
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("ts_highlight", { clear = true }),
			callback = function(ev)
				pcall(vim.treesitter.start, ev.buf)
			end,
		})
	end
end

--------------------------------------------------------------------------------
-- Treesitter textobjects (main branch). Selection (a/i) is handled by mini.ai,
-- matching the old config (its select was disabled). Here we port the MOVE and
-- SWAP keymaps you actually used.
--------------------------------------------------------------------------------
do
	local ok = pcall(require, "nvim-treesitter-textobjects")
	if ok then
		require("nvim-treesitter-textobjects").setup({
			select = { lookahead = true },
			move = { set_jumps = true },
		})

		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")
		local rep = require("nvim-treesitter-textobjects.repeatable_move")

		local function mk(lhs_map, fn, label)
			for lhs, query in pairs(lhs_map) do
				map({ "n", "x", "o" }, lhs, function()
					fn(query, "textobjects")
				end, { desc = label .. " " .. query })
			end
		end

		mk({ ["]f"] = "@call.outer", ["]m"] = "@function.outer", ["]c"] = "@class.outer",
			["]i"] = "@conditional.outer", ["]l"] = "@loop.outer" }, move.goto_next_start, "TS next")
		mk({ ["]F"] = "@call.outer", ["]M"] = "@function.outer", ["]C"] = "@class.outer",
			["]I"] = "@conditional.outer", ["]L"] = "@loop.outer" }, move.goto_next_end, "TS next end")
		mk({ ["[f"] = "@call.outer", ["[m"] = "@function.outer", ["[c"] = "@class.outer",
			["[i"] = "@conditional.outer", ["[l"] = "@loop.outer" }, move.goto_previous_start, "TS prev")
		mk({ ["[F"] = "@call.outer", ["[M"] = "@function.outer", ["[C"] = "@class.outer",
			["[I"] = "@conditional.outer", ["[L"] = "@loop.outer" }, move.goto_previous_end, "TS prev end")

		map("n", "<leader>na", function() swap.swap_next("@parameter.inner") end, { desc = "Swap parameter next" })
		map("n", "<leader>nm", function() swap.swap_next("@function.outer") end, { desc = "Swap function next" })
		map("n", "<leader>pa", function() swap.swap_previous("@parameter.inner") end, { desc = "Swap parameter prev" })
		map("n", "<leader>pm", function() swap.swap_previous("@function.outer") end, { desc = "Swap function prev" })

		-- Make ; , and f F t T repeat textobject/char moves.
		map({ "n", "x", "o" }, ";", rep.repeat_last_move)
		map({ "n", "x", "o" }, ",", rep.repeat_last_move_opposite)
		map({ "n", "x", "o" }, "f", rep.builtin_f_expr, { expr = true })
		map({ "n", "x", "o" }, "F", rep.builtin_F_expr, { expr = true })
		map({ "n", "x", "o" }, "t", rep.builtin_t_expr, { expr = true })
		map({ "n", "x", "o" }, "T", rep.builtin_T_expr, { expr = true })
	end
end

--------------------------------------------------------------------------------
-- mini.surround + mini.ai (mini.pairs was disabled in the old config, so omitted)
--------------------------------------------------------------------------------
require("mini.surround").setup()
require("mini.ai").setup()

--------------------------------------------------------------------------------
-- gitsigns
--------------------------------------------------------------------------------
require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,
	watch_gitdir = { interval = 1000, follow_files = true },
	attach_to_untracked = true,
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> - <summary>",
	current_line_blame_formatter_nc = "  <author>, <author_time:%Y-%m-%d>",
	sign_priority = 6,
	update_debounce = 100,
	max_file_length = 40000,
	preview_config = {
		border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})

--------------------------------------------------------------------------------
-- LuaSnip + friendly-snippets (+ haskell-snippets).
-- NOTE: nvim-next uses native vim.lsp.completion. LuaSnip snippets do NOT show
-- in the native completion menu without a bridge; these keymaps drive snippet
-- expansion/jumping directly. Revisit if you want them in the popup.
--------------------------------------------------------------------------------
do
	local ok, luasnip = pcall(require, "luasnip")
	if ok then
		require("luasnip.loaders.from_vscode").lazy_load() -- friendly-snippets
		local hs_ok, hsnips = pcall(require, "haskell-snippets")
		if hs_ok then
			luasnip.add_snippets("haskell", hsnips.all, { key = "haskell" })
		end
		map({ "i", "s" }, "<C-k>", function()
			if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
		end, { desc = "LuaSnip expand/jump" })
		map({ "i", "s" }, "<C-j>", function()
			if luasnip.jumpable(-1) then luasnip.jump(-1) end
		end, { desc = "LuaSnip jump back" })
	end
end

--------------------------------------------------------------------------------
-- haskell-tools. Owns hls (nvim-next configures no other LSP). on_attach below
-- drops the old `plugins.lsp.handlers` dependency; native completion is enabled
-- by the LspAttach autocmd in init.lua.
--------------------------------------------------------------------------------
vim.g.haskell_tools = {
	hls = {
		on_attach = function(_, bufnr, ht)
			local opts = { noremap = true, silent = true, buffer = bufnr }
			map("n", "<space>ca", vim.lsp.codelens.run, opts)
			map("n", "<space>sh", ht.hoogle.hoogle_signature, opts)
			map("n", "<leader>rr", ht.repl.toggle, opts)
			map("n", "<leader>rf", function()
				ht.repl.toggle(vim.api.nvim_buf_get_name(0))
			end, opts)
			map("n", "<leader>rq", ht.repl.quit, opts)
			map("n", "<leader>hs", "<cmd>Haskell packageYaml<cr>", opts)
			map("n", "<leader>hp", "<cmd>Haskell projectFile<cr>", opts)
			ht.dap.discover_configurations(bufnr)
		end,
	},
	tools = {
		codeLens = { autoRefresh = false },
		hoogle = { mode = "auto" },
	},
}

--------------------------------------------------------------------------------
-- Folds: nvim-origami (foldtext uses gitsigns above)
--------------------------------------------------------------------------------
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
require("origami").setup({
	pauseFoldsOnSearch = true,
	foldtext = {
		enabled = true,
		padding = { character = " ", width = 3, hlgroup = nil },
		lineCount = { template = "%d lines", hlgroup = "Comment" },
		diagnosticsCount = true,
		gitsignsCount = true,
	},
	autoFold = { enabled = false, kinds = { "comment", "imports" } },
	foldKeymaps = { setup = true, hOnlyOpensOnFirstColumn = true },
})

--------------------------------------------------------------------------------
-- statuscolumn: statuscol.nvim (fold column + signs + line numbers)
--------------------------------------------------------------------------------
do
	local builtin = require("statuscol.builtin")
	require("statuscol").setup({
		relculright = true,
		segments = {
			{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
			{ text = { "%s" }, click = "v:lua.ScSa" },
			{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
		},
	})
end

--------------------------------------------------------------------------------
-- nvim-bqf (better quickfix)
--------------------------------------------------------------------------------
vim.cmd([[
  hi BqfPreviewBorder guifg=#50a14f ctermfg=71
  hi link BqfPreviewRange Search
]])
require("bqf").setup({
	auto_enable = true,
	auto_resize_height = true,
	preview = {
		win_height = 12,
		win_vheight = 12,
		delay_syntax = 80,
		border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
		should_preview_cb = function(bufnr, _)
			local ret = true
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local fsize = vim.fn.getfsize(bufname)
			if fsize > 100 * 1024 then
				ret = false
			elseif bufname:match("^fugitive://") then
				ret = false
			end
			return ret
		end,
	},
	func_map = {
		drop = "o",
		openc = "O",
		split = "<C-s>",
		tabdrop = "<C-t>",
		tabc = "",
		ptogglemode = "z,",
	},
	filter = {
		fzf = {
			action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
			extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
		},
	},
})

--------------------------------------------------------------------------------
-- which-key (basic; the old 29k config of group registrations was not ported)
--------------------------------------------------------------------------------
require("which-key").setup({})

--------------------------------------------------------------------------------
-- jj integration: neojj UI (jj-diffconflicts just provides :JJDiffConflicts,
-- referenced by your jj config.toml merge tool — no setup needed)
--------------------------------------------------------------------------------
pcall(function()
	require("neojj").setup()
end)
map("n", "<leader>jj", "<cmd>Neojj<cr>", { desc = "Neojj UI" })

--------------------------------------------------------------------------------
-- nvim-lint (linters are external binaries; install per language as needed)
--------------------------------------------------------------------------------
do
	local lint = require("lint")
	local web_linter = { "biomejs" }

	lint.linters.sqlfluff.args = { "lint", "--format=json", "--dialect=postgres" }
	lint.linters.sqlfluff.parser = function(output, bufnr, _)
		local per_filepath = {}
		if #output > 0 then
			local status, decoded = pcall(vim.json.decode, output)
			if not status then
				per_filepath = {
					{
						filepath = "stdin",
						violations = {
							{
								source = "sqlfluff",
								line_no = 1,
								line_pos = 1,
								code = "jsonparsingerror",
								description = output,
							},
						},
					},
				}
			else
				per_filepath = decoded
			end
		end
		local diagnostics = {}
		for _, i_filepath in ipairs(per_filepath) do
			for _, violation in ipairs(i_filepath.violations) do
				local severity = vim.diagnostic.severity.WARN
				if violation.code == "PRS" then
					severity = vim.diagnostic.severity.ERROR
				end
				table.insert(diagnostics, {
					source = "sqlfluff",
					bufnr = bufnr,
					lnum = (violation.line_no or violation.start_line_no) - 1,
					col = (violation.line_pos or violation.start_line_pos) - 1,
					severity = severity,
					message = violation.description,
					user_data = { lsp = { code = violation.code } },
				})
			end
		end
		return diagnostics
	end

	lint.linters_by_ft = {
		sh = { "shellcheck" },
		haskell = { "hlint" },
		sql = { "sqlfluff" },
		lua = { "selene" },
		javascript = web_linter,
		javascriptreact = web_linter,
		typescript = web_linter,
		typescriptreact = web_linter,
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			local client = vim.lsp.get_clients({ bufnr = 0 })[1] or nil
			if client == nil then
				lint.try_lint()
			else
				lint.try_lint(nil, { cwd = client.root_dir })
			end
		end,
	})
end
