-- Haskell Language Server. Auto-discovered by `vim.lsp.enable("hls")` (init.lua).
-- Binary comes from your nix profile (haskell-language-server-wrapper).
return {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	filetypes = { "haskell", "lhaskell" },
	-- First marker found upward becomes the project root.
	root_markers = { "hie.yaml", "cabal.project", "stack.yaml", "package.yaml", "*.cabal" },
	settings = {
		haskell = {
			-- Matches the fourmolu formatter you already use via conform.
			formattingProvider = "fourmolu",
			cabalFormattingProvider = "cabalfmt",
		},
	},
}
