return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        local web_linter = "eslint_d"
        lint.linters_by_ft = {
            sh = { "shellcheck" },
            -- haskell = { "hlint" },
            lua = { "selene" },
            javascript = { web_linter },
            javascriptreact = { web_linter },
            typescript = { web_linter },
            typescriptreact = { web_linter },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                local get_clients = vim.lsp.get_clients
                local client = get_clients({ bufnr = 0 })[1] or nil

                if client == nil then
                    lint.try_lint()
                else
                    lint.try_lint(nil, { cwd = client.root_dir })
                end
            end,
        })
    end,
}
