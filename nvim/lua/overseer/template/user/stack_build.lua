local overseer = require("overseer")

return {
    name = "stack_build_package",
    desc = "build the package which contains the current file",
    builder = function()
        local utils = require("utils")
        local package_name = utils.get_haskell_package_name()
        return {
            cmd = { "stack" },
            args = { "build", package_name },
            components = {
                { "on_output_quickfix", open = false },
                -- { "on_result_diagnostics_quickfix", open = "true", set_empty_results = "true" },
                {
                    "on_output_parse",
                    parser = {
                        -- Put the parser results into the 'diagnostics' field on the task result
                        diagnostics = {
                            -- Extract fields using lua patterns
                            -- To integrate with other components, items in the "diagnostics" result should match
                            -- vim's quickfix item format (:help setqflist)
                            { "skip_until", { skip_matching_line = false }, "error:", "warning:" },
                            {
                                "extract",
                                "^([^%s].+):(%d+):(%d+): (.*): (.*)$",
                                "filename",
                                "lnum",
                                "col",
                                "severity",
                                "ghcerr",
                            },
                            { "extract_multiline", "^(    .+)", "text" },
                        },
                    },
                },
                "default",
                "unique",
            },
        }
    end,
    tags = { overseer.TAG.BUILD },
    condition = {
        filetype = { "haskell" },
    },
}
