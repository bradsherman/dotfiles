return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        local web_linter = { "eslint_d" }

        lint.linters.sqlfluff.args = { "lint", "--format=json", "--dialect=postgres" }
        -- lint.linters.sqlfluff.stdin = true
        lint.linters.sqlfluff.parser = function(output, bufnr, _)
            local per_filepath = {}
            if #output > 0 then
                local status, decoded = pcall(vim.json.decode, output)
                if not status then
                    per_filepath = {
                        {
                            filepath = "stdin",
                            violations = {
                                {
                                    source = "sqlfluff",
                                    line_no = 1,
                                    line_pos = 1,
                                    code = "jsonparsingerror",
                                    description = output,
                                },
                            },
                        },
                    }
                else
                    per_filepath = decoded
                end
            end
            local diagnostics = {}
            for _, i_filepath in ipairs(per_filepath) do
                for _, violation in ipairs(i_filepath.violations) do
                    local severity = vim.diagnostic.severity.WARN
                    if violation.code == "PRS" then
                        severity = vim.diagnostic.severity.ERROR
                    end
                    vim.print(violation.description)
                    table.insert(diagnostics, {
                        source = "sqlfluff",
                        bufnr = bufnr,
                        lnum = (violation.line_no or violation.start_line_no) - 1,
                        col = (violation.line_pos or violation.start_line_pos) - 1,
                        severity = severity,
                        message = violation.description,
                        user_data = { lsp = { code = violation.code } },
                    })
                end
            end
            return diagnostics
        end

        lint.linters_by_ft = {
            sh = { "shellcheck" },
            -- haskell = { "hlint" },
            sql = { "sqlfluff" },
            lua = { "selene" },
            javascript = web_linter,
            javascriptreact = web_linter,
            typescript = web_linter,
            typescriptreact = web_linter,
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
