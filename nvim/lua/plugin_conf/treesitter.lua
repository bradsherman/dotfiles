require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "haskell","graphql","json","javascript","yaml","bash","typescript","html","clojure","rust","lua","python" },
  highlight = { enable = true },
  indent = { enable = true }
}

