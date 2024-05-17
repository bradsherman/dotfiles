return {
    "linrongbin16/gitlinker.nvim",
    config = function()
        require("gitlinker").setup({
            router = {
                default_branch = {
                    ["^github%.com"] = "https://github.com/"
                        .. "{_A.ORG}/"
                        .. "{_A.REPO}/blob/"
                        .. "{_A.DEFAULT_BRANCH}/" -- always 'master'/'main' branch
                        .. "{_A.FILE}?plain=1" -- '?plain=1'
                        .. "#L{_A.LSTART}"
                        .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
                },
                current_branch = {
                    ["^github%.com"] = "https://github.com/"
                        .. "{_A.ORG}/"
                        .. "{_A.REPO}/blob/"
                        .. "{_A.CURRENT_BRANCH}/" -- always current branch
                        .. "{_A.FILE}?plain=1" -- '?plain=1'
                        .. "#L{_A.LSTART}"
                        .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
                },
            },
        })
    end,
    keys = {
        { "<leader>gy", "<cmd>GitLink default_branch<cr>", desc = "GitLink - Default Branch" },
        { "<leader>gu", "<cmd>GitLink<cr>", desc = "GitLink - Current Rev" },
    },
}
