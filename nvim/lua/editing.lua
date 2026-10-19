local map = vim.keymap.set

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

		mk({
			["]f"] = "@call.outer",
			["]m"] = "@function.outer",
			["]c"] = "@class.outer",
			["]i"] = "@conditional.outer",
			["]l"] = "@loop.outer",
		}, move.goto_next_start, "TS next")
		mk({
			["]F"] = "@call.outer",
			["]M"] = "@function.outer",
			["]C"] = "@class.outer",
			["]I"] = "@conditional.outer",
			["]L"] = "@loop.outer",
		}, move.goto_next_end, "TS next end")
		mk({
			["[f"] = "@call.outer",
			["[m"] = "@function.outer",
			["[c"] = "@class.outer",
			["[i"] = "@conditional.outer",
			["[l"] = "@loop.outer",
		}, move.goto_previous_start, "TS prev")
		mk({
			["[F"] = "@call.outer",
			["[M"] = "@function.outer",
			["[C"] = "@class.outer",
			["[I"] = "@conditional.outer",
			["[L"] = "@loop.outer",
		}, move.goto_previous_end, "TS prev end")

		map("n", "<leader>na", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap parameter next" })
		map("n", "<leader>nm", function()
			swap.swap_next("@function.outer")
		end, { desc = "Swap function next" })
		map("n", "<leader>pa", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap parameter prev" })
		map("n", "<leader>pm", function()
			swap.swap_previous("@function.outer")
		end, { desc = "Swap function prev" })
	end
end

require("mini.surround").setup()
require("mini.ai").setup()
for _, motion in ipairs({ "w", "e", "b", "ge" }) do
	map({ "n", "x", "o" }, motion, function()
		require("spider").motion(motion)
	end, { desc = "Spider " .. motion })
end

local ls = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
ls.add_snippets("haskell", require("haskell-snippets").all, { key = "haskell" })
-- Native LSP completion expands server snippets with vim.snippet; local snippet
-- collections use LuaSnip. These keys navigate either engine without replacing it.
map({ "i", "s" }, "<C-k>", function()
	if vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
	elseif ls.expand_or_locally_jumpable() then
		ls.expand_or_jump()
	end
end, { desc = "Expand snippet / next placeholder" })
map({ "i", "s" }, "<C-j>", function()
	if vim.snippet.active({ direction = -1 }) then
		vim.snippet.jump(-1)
	elseif ls.locally_jumpable(-1) then
		ls.jump(-1)
	end
end, { desc = "Previous snippet placeholder" })
map({ "i", "s" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { desc = "Next snippet choice" })

-- Treesitter supplies fold ranges; indent folding covers files without a parser.
local function folds()
	if vim.bo.buftype ~= "" then
		return
	end
	local ok = pcall(vim.treesitter.get_parser, 0)
	vim.wo.foldmethod = ok and "expr" or "indent"
	vim.wo.foldexpr = ok and "v:lua.vim.treesitter.foldexpr()" or "0"
end
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("EditorFolds", { clear = true }),
	callback = folds,
})
require("origami").setup({ foldtext = { gitsignsCount = false }, autoFold = { enabled = false } })
local builtin = require("statuscol.builtin")
require("statuscol").setup({
	relculright = true,
	segments = {
		{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
		{ text = { "%s" }, click = "v:lua.ScSa" },
		{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
	},
})
require("bqf").setup({ auto_resize_height = true })

require("csvview").setup({
	parser = { comments = { "#", "//" } },
	keymaps = {
		textobject_field_inner = { "if", mode = { "o", "x" } },
		textobject_field_outer = { "af", mode = { "o", "x" } },
		jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
		jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
		jump_next_row = { "<Enter>", mode = { "n", "v" } },
		jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
	},
})
map("n", "<leader>tc", "<cmd>CsvViewToggle<cr>", { desc = "Toggle CSV viewer" })

-- Keep Ctrl-F (files), Ctrl-B (buffers), and Ctrl-E (Oil) intact.
local scroll = require("neoscroll")
scroll.setup({ mappings = {}, hide_cursor = true, easing = "quadratic" })
for key, action in pairs({ ["<C-u>"] = "ctrl_u", ["<C-d>"] = "ctrl_d", ["zt"] = "zt", ["zz"] = "zz", ["zb"] = "zb" }) do
	map({ "n", "x" }, key, function()
		scroll[action]({ duration = 200, half_win_duration = 200 })
	end, { desc = "Smooth scroll " .. action })
end
map({ "n", "x" }, "<C-y>", function()
	scroll.scroll(-0.1, { move_cursor = false, duration = 100 })
end, { desc = "Smooth scroll up" })
