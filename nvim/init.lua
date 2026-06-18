require("options")
require("keybindings")
require("lazy-plugins")
require("autocommands")
require("lsp")

local rocks_config = {
    rocks_path = "/home/bsherman/.local/share/nvim/rocks",
    luarocks_binary = "/home/bsherman/.local/share/nvim/rocks/bin/luarocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}

package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
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
        "html",
        "http",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "ninja",
        "nix",
        -- "norg",
        "ocaml",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "terraform",
        "vim",
        "xml",
        "yaml",
        "zig",
    },
    callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

require("vim._core.ui2").enable({})
