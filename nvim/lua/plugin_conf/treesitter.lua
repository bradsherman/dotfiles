local parser_status_ok, parsers = pcall(require, "nvim-treesitter.parsers")
local configs_status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not parser_status_ok or not configs_status_ok then
    return
end

local parser_configs = parsers.get_parser_configs()
parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main",
    },
}

configs.setup({
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        "bash",
        "clojure",
        "cpp",
        "css",
        "diff",
        "git_rebase",
        "gitcommit",
        "go",
        "graphql",
        "haskell",
        "hcl",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "ninja",
        "nix",
        "norg",
        "ocaml",
        "org",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "typescript",
        "vim",
        "yaml",
    },
    -- setting this to true looks nice but drastically reduces UI responsiveness
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    autopairs = { enable = true },
    autotag = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
})
