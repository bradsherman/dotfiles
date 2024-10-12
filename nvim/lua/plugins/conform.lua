return {
    "stevearc/conform.nvim",
    config = function(_, opts)
        local opts_with_fourmolu = {
            formatters = {
                fourmolu = {
                    -- This can be a string or a function that returns a string
                    command = "fourmolu",
                    -- OPTIONAL - all fields below this are optional
                    -- A list of strings, or a function that returns a list of strings
                    args = { "--stdin-input-file", "$FILENAME" },
                    -- If the formatter supports range formatting, create the range arguments here
                    range_args = function(ctx)
                        return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
                    end,
                    -- Send file contents to stdin, read new contents from stdout (default true)
                    -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
                    -- file is assumed to be modified in-place by the format command.
                    stdin = true,
                    -- A function that calculates the directory to run the command in
                    cwd = require("conform.util").root_file({ "stack.yaml", "fourmolu.yaml" }),
                    -- When cwd is not found, don't run the formatter (default false)
                    require_cwd = true,
                },
            },
        }
        local full_opts = vim.tbl_deep_extend("force", opts, opts_with_fourmolu)

        require("conform").setup(full_opts)
        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })

        require("conform.formatters.prettier").condition = function()
            return true
            -- TODO: skip disabled filetypes
            -- return vim.fs.basename(ctx.filename)
            -- disabled_filetypes = { "html", "json", "yaml", "markdown" },
        end
        require("conform").formatters.injected = {
            -- Set the options field
            options = {
                -- Set individual option values
                ignore_errors = true,
                lang_to_formatters = {
                    json = { "jq" },
                },
            },
        }
    end,
    opts = {
        -- logging = true,
        -- log_level = vim.log.levels.DEBUG,
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            -- Use a sub-list to run only the first available formatter
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            sql = { "sqlfluff" },
            nix = { "nixfmt" },
            haskell = { "fourmolu" },
            ["*"] = { "trim_whitespace", "trim_newlines" },
        },
        format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_fallback = true }
        end,
    },
}
