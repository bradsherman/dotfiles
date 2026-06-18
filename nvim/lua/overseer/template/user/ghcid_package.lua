local overseer = require("overseer")

return {
    name = "ghcid_package",
    desc = "use ghcid to build the package which contains the current file",
    builder = function()
        local utils = require("utils")
        local package_name = utils.get_haskell_package_name()
        local cabal_file = utils.get_haskell_cabal_file()
        return {
            cmd = { "ghcid" },
            args = { "--command", "cabal repl " .. package_name, "--warnings", "--restart", cabal_file },
            components = {
                { "on_output_quickfix", open = false },
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
