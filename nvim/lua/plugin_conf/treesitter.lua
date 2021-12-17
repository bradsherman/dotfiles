local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    "norg",
    "haskell",
    "graphql",
    "json",
    "javascript",
    "yaml",
    "bash",
    "typescript",
    "markdown",
    "html",
    "clojure",
    "rust",
    "lua",
    "python"
  },
  -- setting this to true looks nice but drastically reduces UI responsiveness
  highlight = { enable = false },
  indent = { enable = true },
  autopairs = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false }
}

