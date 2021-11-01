require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "haskell","graphql","json","javascript","yaml","bash","typescript","html","clojure","rust","lua","python" },
  -- setting this to true looks nice but drastically reduces UI responsiveness
  highlight = { enable = false },
  indent = { enable = true }
}

