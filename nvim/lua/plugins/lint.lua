return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            sh = { "shellcheck" },
            -- haskell = { "hlint" },
            lua = { "selene" },
        }

        local web_languages = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
        }
        -- use eslint until eslint_d upgrades to new format
        for _, name in pairs(web_languages) do
            if not lint.linters_by_ft[name] then
                lint.linters_by_ft[name] = { "eslint" }
            end
            -- if not vim.tbl_contains(lint.linters_by_ft[name], "eslint_d") then
            --     table.insert(lint.linters_by_ft[name], "eslint_d")
            -- end
        end

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
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
