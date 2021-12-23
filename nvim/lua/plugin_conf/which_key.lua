local wk = require("which-key")

-- Packer
wk.register({
	p = {
		name = "+Packer",
		i = { ":PackerInstall<cr>", "Packer Install" },
		u = { ":PackerSync<cr>", "Packer Sync" },
	},
}, { prefix = "<leader>" })

-- Zen Mode
wk.register({
	z = {
		name = "ZenMode",
		m = {
			"<cmd> execute luaeval(\"require('zen-mode').toggle({ window = { width = .85 } })\")<cr>",
			"Toggle Zen Mode",
		},
	},
}, { prefix = "<leader>" })

wk.register({
	["<leader><tab>"] = { ":b#<cr>", "Previous Buffer" },
}, {})

wk.register({
	["<leader>e"] = { ":NvimTreeFindFile<cr>", "NvimTree Find File" },
}, {})

-- Lsp
wk.register({
	["<leader>l"] = {
		name = "+LSP Actions",
		a = { "<cmd>Telescope lsp_code_actions theme=cursor<cr>", "Code Actions" },
		d = { "<cmd>Telescope diagnostics<cr>", "LSP Diagnostics" },
		e = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		h = { "<cmd>Lspsaga signature_help<cr>", "Signature Help" },
		i = { "<cmd>LspInfo<cr>", "LSP Info" },
		r = { "<cmd>lua require('renamer').rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_workspace_symbols theme=ivy<cr>", "LSP Workspace Symbols" },
	},
	g = {
		name = "+LSP Types",
		d = { "<cmd>Telescope lsp_definitions<cr>", "Definitions" },
		D = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definitions" },
		i = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
		K = { "<cmd>Lspsaga hover_doc<cr>", "Hover Doc" },
		m = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		r = { "<cmd>Telescope lsp_references<cr>", "References" },
		t = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Definitions" },
	},
}, {})

-- Git
wk.register({
	g = {
		name = "+Git",
		s = { ":G<cr>", "Git Status" },
		c = { ":Telescope git_branches", "Git Branches" },
		g = { ":Neogit<cr>", "Neogit" },
	},
}, { prefix = "<leader>" })
