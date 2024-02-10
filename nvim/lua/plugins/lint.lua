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
        for _, name in pairs(web_languages) do
            if not lint.linters_by_ft[name] then
                lint.linters_by_ft[name] = { "eslint" }
            end
            if not vim.tbl_contains(lint.linters_by_ft[name], "eslint") then
                table.insert(lint.linters_by_ft[name], "eslint")
            end
        end

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
