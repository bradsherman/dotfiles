return {
    "folke/which-key.nvim",
    -- event = "VeryLazy",
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        local show = wk.show
        wk.show = function(keys, opts2)
            if vim.bo.filetype == "TelescopePrompt" then
                local map = "<c-r>"
                local key = vim.api.nvim_replace_termcodes(map, true, false, true)
                vim.api.nvim_feedkeys(key, "i", true)
            end
            show(keys, opts2)
        end

        local update_haskell_tags = require("utils").update_haskell_tags

        -- Miscellaneous Telescope mappings
        wk.add({
            -- { "<c-f>", "<cmd>FzfLua files<cr>", desc = "Files" },
            -- { "<c-g>", "<cmd>FzfLua live_grep_glob<cr>", desc = "Grep" },
            -- { "<c-g>", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
            -- { "<c-b>", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
            -- { "<c-t>", "<cmd>FzfLua tags<cr>", desc = "Tags" },
            -- { "R", "<cmd>FzfLua resume<cr>", desc = "Resume" },

            { "<c-f>", "<cmd>Telescope find_files<cr>", desc = "Telescope Files" },
            -- { "<c-g>", "<cmd>Telescope egrepify<cr>", desc = "Telescope Grep" },
            { "<c-g>", require("plugins.telescope.multigrep").live_multigrep, desc = "Telescope Grep" },
            -- ["<c-g>"] = {
            --     "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
            --     "Telescope Grep",
            -- },
            { "<c-b>", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffers" },
            { "<c-t>", "<cmd>Telescope tags<cr>", desc = "Telescope Tags" },

            { "<leader>gd", "<cmd>GrepInDirectory<cr>", desc = "Search In Directory" },
            {
                "<leader>fh",
                "<cmd>lua require('telescope.builtin').live_grep({glob_pattern='*.hs'})<cr>",
                desc = "Grep Haskell Files",
            },
            {
                "<leader>ft",
                "<cmd>lua require('telescope.builtin').live_grep({glob_pattern={'*.ts','*.js','*.tsx','*.jsx','*.css','*.scss'}})<cr>",
                desc = "Grep Web Files",
            },
            { "<leader>ff", "<cmd>lua MiniFiles.open()<cr>", desc = "Mini Files" },
            {
                "<leader>fg",
                "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
                desc = "Live Grep Args",
            },
            {
                "<leader>fe",
                "<cmd>require('telescope').extensions.file_browser.file_browser()<cr>",
                desc = "Telescope File Browser",
            },
            {
                "<leader>f?",
                "<cmd>lua require('notify').notify(vim.fn.expand('%f'))<cr>",
                desc = "What file am I?",
            },
            { "<leader>qr", "<cmd>lua require('plugin_conf/telescope').reload()<cr>", desc = "Reload Modules" },
            { "<leader>bd", "<cmd>bufdo :Bdelete<cr>", desc = "Clear Buffers" },
            { "<leader>sn", "<cmd>Telescope manix<cr>", desc = "Search Nix" },
        })

        -- GrugFar
        wk.add({
            { "<leader>far", "<cmd>GrugFar<cr>", desc = "Find And Replace" },
        })

        -- Overseer
        wk.add({
            { "<leader>b", group = "+Overseer" },
            { "<leader>ba", "<cmd>OverseerTaskAction<cr>", desc = "Action" },
            { "<leader>bb", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last" },
            { "<leader>bi", "<cmd>OverseerInfo<cr>", desc = "Info" },
            { "<leader>br", "<cmd>OverseerRun<cr>", desc = "Run" },
            { "<leader>bs", "<cmd>OverseerRun stack_build_package<cr>", desc = "Build Stack Package" },
            { "<leader>bt", "<cmd>OverseerToggle<cr>", desc = "Toggle" },
        })

        -- Quickfix
        wk.add({
            { "<leader>q", group = "+Quickfix" },
            { "<leader>qj", "<cmd>cnext<cr>", desc = "Quickfix next" },
            { "<leader>qk", "<cmd>cprev<cr>", desc = "Quickfix prev" },
            { "<leader>qc", "<cmd>copen<cr>", desc = "Quickfix open" },
            { "<leader>qq", "<cmd>cclose<cr>", desc = "Quickfix close" },
        })

        -- Colorizer
        -- wk.add({
        --     { "<leader>ct", "<cmd>HighlightColors Toggle<cr>", desc = "Toggle Colorizer" },
        -- })

        -- Code Companion
        wk.add({
            { "<leader>c", group = "+Code Companion" },
            { "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "Open Chat" },
            { "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle" },
        })

        -- Markdown Preview
        wk.add({
            { "<leader>m", group = "+Markdown" },
            { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
            { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop" },
            { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle" },
        })

        -- Lazy
        wk.add({
            { "<leader>p", "+Lazy" },
            { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Lazy Sync" },
            { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Lazy Update" },
        })

        -- Zen Mode
        wk.add({
            { "<leader>z", group = "+ZenMode" },
            { "<leader>zm", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
            { "<leader>zt", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
        })

        -- Misc
        wk.add({
            { "<leader><tab>", "<cmd>b#<cr>", desc = "Previous Buffer" },
            { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle TableMode" },
            { "<leader>sw", "<cmd>set list!<cr>", desc = "Show Whitespace Chars" },
            { "<leader>se", "<cmd>Eswpoch<cr>", desc = "Epoch Switcher" },
            {
                "<leader>fe",
                "<cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>",
                desc = "Telescope File Browser",
            },
            { "<leader>nc", "<cmd>lua require('notify').dismiss({pending = true})<cr>", desc = "Clear Notifications" },
            { "<leader>hs", "<cmd>Haskell packageYaml", desc = "Package Yaml" },
            { "<leader>hp", "<cmd>Haskell projectFile", desc = "Project File" },
            -- { "<leader>a", "<cmd>AerialToggle!<cr>", desc = "Aerial Toggle" },
        })

        wk.add({
            { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
            { "<C-e>", "<cmd>Oil<cr>", desc = "Open parent directory" },
            { "<leader>e", "<cmd>Oil<cr>", desc = "Open parent directory" },
            -- { "-", "<cmd>lua MiniFiles.open()<cr>", desc = "Mini Files" },
            -- { "<C-e>", "<cmd>lua MiniFiles.open()<cr>", desc = "Mini Files" },
            -- { "<leader>e", "<cmd>lua MiniFiles.open()<cr>", desc = "Mini Files" },
        })

        -- Lsp
        wk.add({
            {
                { "<leader>l", group = "+LSP Actions" },
                { "<leader>la", "<cmd>lua require('fastaction').code_action()<cr>", desc = "Code Actions" },
                -- { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
                { "<leader>ld", "<cmd>Telescope diagnostics<cr>", desc = "LSP Diagnostics" },
                { "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", desc = "Format" },
                { "<leader>li", "<cmd>TSToolsOrganizeImports<cr>", desc = "TSToolsOrganizeImports" },
                { "<leader>ll", vim.lsp.codelens.run, desc = "LSP Code Lens" },
                { "<leader>lr", "<cmd>IncRename " .. vim.fn.expand("<cword>") .. "<cr>", desc = "Rename" },
                { "<leader>ls", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "LSP Workspace Symbols" },
                { "<leader>lu", update_haskell_tags, desc = "Update Haskell tags" },
            },
            {
                "<c-p>",
                function()
                    vim.diagnostic.jump({ count = -1, float = false })
                    -- assume current buffer
                    -- require("tiny-inline-diagnostic").get_diagnostic_under_cursor(0)
                end,
                desc = "Prev Diagnostic",
            },
            {
                "<c-n>",
                function()
                    vim.diagnostic.jump({ count = 1, float = false })
                    -- assume current buffer
                    -- require("tiny-inline-diagnostic").get_diagnostic_under_cursor(0)
                end,
                desc = "Next Diagnostic",
            },
            {
                { "g", group = "+LSP Types" },
                { "gd", "<cmd>FzfLua lsp_definitions<cr>", desc = "Definitions" },
                { "gi", "<cmd>FzfLua lsp_implementations<cr>", desc = "Implementations" },
                { "gK", require("hover").hover, desc = "Hover Doc" },
                { "gm", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols" },
                -- { "gr", "<cmd>FzfLua lsp_references<cr>", desc = "References" },
                -- { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
                { "gt", "<cmd>FzfLua lsp_typedefs<cr>", desc = "Type Definitions" },
            },
        })

        -- Git
        wk.add({
            { "<leader>g", group = "+Git" },
            { "<leader>bg", "<cmd>FzfLua git_branches<cr>", desc = "Git Branches" },
            -- Neogit
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
            {
                { "<leader>gc", group = "+Conflict" },
                { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose Both" },
                { "<leader>gcj", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
                { "<leader>gck", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous Conflict" },
                { "<leader>gcl", "<cmd>GitConflictListQf<cr>", desc = "To Quickfix" },
                { "<leader>gcn", "<cmd>GitConflictChooseNone<cr>", desc = "Choose None" },
                { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose Ours" },
                { "<leader>gcr", "<cmd>GitConflictRefresh<cr>", desc = "Refresh" },
                { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs" },
            },
            {
                { "<leader>gd", group = "+Diffview/Gitsigns" },
                { "<leader>gdc", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>", desc = "Compare Branch" },
                { "<leader>gdd", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
                { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
                { "<leader>gdh", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Diffview Open Last Commit" },
                { "<leader>gdl", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
                { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
                {
                    "<leader>gdr",
                    "<cmd>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges<cr>",
                    desc = "Compare Branch (commitwise)",
                },
                { "<leader>gds", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
                { "<leader>gdx", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
            },
            {
                { "<leader>gh", group = "+Github" },
                {
                    { "<leader>ghc", group = "+Commits" },
                    { "<leader>ghcc", "<cmd>GHCloseCommit<cr>", desc = "Close" },
                    { "<leader>ghce", "<cmd>GHExpandCommit<cr>", desc = "Expand" },
                    { "<leader>ghco", "<cmd>GHOpenToCommit<cr>", desc = "Open To" },
                    { "<leader>ghcp", "<cmd>GHPopOutCommit<cr>", desc = "Pop Out" },
                    { "<leader>ghcz", "<cmd>GHCollapseCommit<cr>", desc = "Collapse" },
                },
                { "<leader>ghd", "<cmd>GHOpenDebugBuffer<cr>", desc = "Open Debug Buffer" },
                {
                    { "<leader>ghi", group = "+Issues" },
                    { "<leader>ghil", "<cmd>Octo issue list<cr>", desc = "List Issues (Octo)" },
                    { "<leader>ghip", "<cmd>GHPreviewIssue<cr>", desc = "Preview" },
                },
                {
                    { "<leader>ghl", group = "+Litee/Labels" },
                    { "<leader>ghla", "<cmd>GHAddLabel<cr>", desc = "Add Label to PR" },
                    { "<leader>ghlr", "<cmd>GHRemoveLabel<cr>", desc = "Remove Label to PR" },
                    { "<leader>ghlt", "<cmd>LTPanel<cr>", desc = "Toggle Panel" },
                },
                {
                    { "<leader>ghr", group = "+Review" },
                    { "<leader>ghrb", "<cmd>GHStartReview<cr>", desc = "Begin" },
                    { "<leader>ghrc", "<cmd>GHCloseReview<cr>", desc = "Close" },
                    { "<leader>ghrd", "<cmd>GHDeleteReview<cr>", desc = "Delete" },
                    { "<leader>ghre", "<cmd>GHExpandReview<cr>", desc = "Expand" },
                    { "<leader>ghrs", "<cmd>GHSubmitReview<cr>", desc = "Submit" },
                    { "<leader>ghrz", "<cmd>GHCollapseReview<cr>", desc = "Collapse" },
                },
                {
                    { "<leader>ghp", name = "+Pull Request" },
                    { "<leader>ghpc", "<cmd>GHClosePR<cr>", desc = "Close" },
                    { "<leader>ghpd", "<cmd>GHPRDetails<cr>", desc = "Details" },
                    { "<leader>ghpe", "<cmd>GHExpandPR<cr>", desc = "Expand" },
                    { "<leader>ghpl", "<cmd>Octo pr list<cr>", desc = "List (Octo)" },
                    { "<leader>ghpm", "<cmd>GHRequestedReview<cr>", desc = "My PRs To Review" },
                    { "<leader>ghpo", "<cmd>GHOpenPR<cr>", desc = "Open" },
                    { "<leader>ghpp", "<cmd>GHPopOutPR<cr>", desc = "PopOut" },
                    { "<leader>ghpr", "<cmd>GHRefreshPR<cr>", desc = "Refresh" },
                    { "<leader>ghps", "<cmd>GHSearchPRs<cr>", desc = "Search All PRs" },
                    { "<leader>ghpt", "<cmd>GHOpenToPR<cr>", desc = "Open To" },
                    { "<leader>ghpz", "<cmd>GHCollapsePR<cr>", desc = "Collapse" },
                },
                {
                    { "<leader>ght", name = "+Threads" },
                    { "<leader>ghtc", "<cmd>GHCreateThread<cr>", desc = "Create" },
                    { "<leader>ghtn", "<cmd>GHNextThread<cr>", desc = "Next" },
                    { "<leader>ghtt", "<cmd>GHToggleThreads<cr>", desc = "Toggle" },
                },
            },
            { "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk" },
            { "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous Hunk" },
            {
                { "<leader>gw", group = "+Worktree" },
                {
                    "<leader>gwc",
                    "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
                    desc = "Create",
                },
                {
                    "<leader>gws",
                    function()
                        require("telescope").extensions.git_worktree.git_worktrees({
                            path_display = {},
                        })
                    end,
                    desc = "Switch",
                },
            },
            {
                { "<leader>go", group = "+Octo" },
                {
                    { "<leader>goc", group = "+Comment" },
                    { "<leader>goca", "<cmd>Octo comment add<cr>", desc = "Add a comment" },
                    { "<leader>gocd", "<cmd>Octo comment delete<cr>", desc = "Delete a comment" },
                },
                {
                    { "<leader>goi", group = "+Issue" },
                    { "<leader>goib", "<cmd>Octo issue browser<cr>", desc = "Open current issue in browser" },
                    { "<leader>goic", "<cmd>Octo issue create<cr>", desc = "Create an issue" },
                    { "<leader>goie", "<cmd>Octo issue edit<cr>", desc = "Edit an issue" },
                    { "<leader>goil", "<cmd>Octo issue list<cr>", desc = "List issues" },
                    { "<leader>goio", "<cmd>Octo issue reopen<cr>", desc = "Reopen the current issue" },
                    { "<leader>goir", "<cmd>Octo issue reload<cr>", desc = "Reload the current issue" },
                    { "<leader>gois", "<cmd>Octo issue search<cr>", desc = "Search issues" },
                    { "<leader>goiu", "<cmd>Octo issue url<cr>", desc = "Copy current issue url" },
                    { "<leader>goix", "<cmd>Octo issue close<cr>", desc = "Close the current issue" },
                },
                {
                    -- Not included: changes
                    { "<leader>gop", group = "+PR" },
                    { "<leader>gopa", "<cmd>Octo pr ready<cr>", desc = "Mark PR as ready for review" },
                    { "<leader>gopb", "<cmd>Octo pr browser<cr>", desc = "Open PR in browser" },
                    { "<leader>gopc", "<cmd>Octo pr commits<cr>", desc = "List PR Commits" },
                    { "<leader>gopd", "<cmd>Octo pr diff<cr>", desc = "Diff PR" },
                    { "<leader>gope", "<cmd>Octo pr edit<cr>", desc = "Edit PR" },
                    { "<leader>gopf", "<cmd>Octo pr search<cr>", desc = "Search PRs" },
                    { "<leader>gopl", "<cmd>Octo pr list<cr>", desc = "List PRs" },
                    {
                        { "<leader>gopm", group = "+Merge" },
                        { "<leader>gopmc", "<cmd>Octo pr merge commit<cr>", desc = "Merge PR with commit strategy" },
                        { "<leader>gopmd", "<cmd>Octo pr merge delete<cr>", desc = "Merge PR with delete strategy" },
                        { "<leader>gopmr", "<cmd>Octo pr merge rebase<cr>", desc = "Merge PR with rebase strategy" },
                        { "<leader>gopms", "<cmd>Octo pr merge squash<cr>", desc = "Merge PR with squash strategy" },
                    },
                    { "<leader>gopn", "<cmd>Octo pr create<cr>", desc = "Create PR" },
                    { "<leader>gopp", "<cmd>Octo pr checkout<cr>", desc = "Checkout PR" },
                    { "<leader>gopr", "<cmd>Octo pr reopen<cr>", desc = "Reopen PR" },
                    { "<leader>gops", "<cmd>Octo pr checks<cr>", desc = "Show Status of Checks on PR" },
                    { "<leader>gopt", "<cmd>Octo pr reload<cr>", desc = "Reload PR" },
                    { "<leader>gopu", "<cmd>Octo pr url<cr>", desc = "Copy url to PR" },
                    { "<leader>gopx", "<cmd>Octo pr close<cr>", desc = "Close PR" },
                },
                {
                    { "<leader>gor", group = "+Review" },
                    { "<leader>gorc", "<cmd>Octo review commit<cr>", desc = "Pick a commit to review" },
                    { "<leader>gord", "<cmd>Octo review discard<cr>", desc = "Discard a pending review" },
                    { "<leader>gorf", "<cmd>Octo review submit<cr>", desc = "Submit the review" },
                    { "<leader>gorr", "<cmd>Octo review resume<cr>", desc = "Resume a pending review" },
                    { "<leader>gors", "<cmd>Octo review start<cr>", desc = "Start a new review" },
                    { "<leader>gort", "<cmd>Octo review comments<cr>", desc = "View pending comments" },
                    { "<leader>gorx", "<cmd>Octo review close<cr>", desc = "Close the review" },
                },
                {
                    { "<leader>got", group = "+Thread" },
                    { "<leader>gotr", "<cmd>Octo thread resolve<cr>", desc = "Resolve thread" },
                    { "<leader>gotu", "<cmd>Octo thread unresolve<cr>", desc = "Unresolve thread" },
                },
            },
        })

        -- Debug
        wk.add({
            {
                { "<leader>d", group = "+Debug" },
                {
                    { "<leader>ds", group = "+Step" },
                    { "<leader>dsc", "<cmd>lua require('dap').continue()<CR>", desc = "Continue" },
                    { "<leader>dsv", "<cmd>lua require('dap').step_over()<CR>", desc = "Step Over" },
                    { "<leader>dsi", "<cmd>lua require('dap').step_into()<CR>", desc = "Step Into" },
                    { "<leader>dso", "<cmd>lua require('dap').step_out()<CR>", desc = "Step Out" },
                },
                {
                    { "<leader>dh", group = "+Hover" },
                    { "<leader>dhh", "<cmd>lua require('dap.ui.variables').hover()<CR>", desc = "Hover" },
                    { "<leader>dhv", "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", desc = "Visual Hover" },
                },
                {
                    { "<leader>du", group = "+UI" },
                    { "<leader>duh", "<cmd>lua require('dap.ui.widgets').hover()<CR>", desc = "Hover" },
                    {
                        "<leader>duf",
                        "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>",
                        desc = "Float",
                    },
                },
                {
                    { "<leader>dr", group = "+REPL" },
                    { "<leader>dro", "<cmd>lua require('dap').repl.open()<CR>", desc = "Open" },
                    { "<leader>drl", "<cmd>lua require('dap').repl.run_last()<CR>", desc = "Run Last" },
                },
                {
                    { "<leader>db", group = "+Breakpoints" },
                    {
                        "<leader>dbc",
                        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                        desc = "Breakpoint Condition",
                    },
                    {
                        "<leader>dbm",
                        "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
                        desc = "Log Point Message",
                    },
                    {
                        "<leader>dbt",
                        "<cmd>lua require('dap').toggle_breakpoint()<CR>",
                        desc = "Create",
                    },
                },
                { "<leader>dc", "<cmd>lua require('dap').scopes()<CR>", desc = "Scopes" },
                { "<leader>di", "<cmd>lua require('dap').toggle()<CR>", desc = "Toggle" },
            },
        })

        -- Syntax Tree Surfer
        -- local surfer_ok, _ = pcall(require, "syntax-tree-surfer")
        -- if surfer_ok then
        --     local swapper = function(cmd)
        --         vim.opt.opfunc = cmd
        --         return "g@l"
        --     end
        --     wk.add({
        --         {
        --             { "v", group = "+Syntax Tree Surfer" },
        --             {
        --                 "vd",
        --                 function()
        --                     swapper("v:lua.STSSwapCurrentNodeNextNormal_Dot")
        --                 end,
        --                 desc = "Swap Current Next",
        --             },
        --             {
        --                 "vD",
        --                 function()
        --                     swapper("v:lua.STSSwapDownNormal_Dot")
        --                 end,
        --                 desc = "Swap Master Next",
        --             },
        --             {
        --                 "vu",
        --                 function()
        --                     swapper("v:lua.STSSwapCurrentNodePrevNormal_Dot")
        --                 end,
        --                 desc = "Swap Current Prev",
        --             },
        --             {
        --                 "vU",
        --                 function()
        --                     swapper("v:lua.STSSwapUpNormal_Dot")
        --                 end,
        --                 desc = "Swap Master Prev",
        --             },
        --             -- u = { "<cmd>lua require('syntax-tree-surfer').move('n', true)<cr>", "Previous" },
        --             -- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
        --             { "vx", "<cmd>STSSelectMasterNode<cr>", desc = "Select" },
        --             -- .select_current_node() will select the current node at your cursor
        --             { "vn", "<cmd>STSSelectCurrentNode<cr>", desc = "Select Current" },
        --         },
        --     })
        --
        --     wk.add({
        --         {
        --             mode = "x",
        --             { "J", "<cmd>STSSelectNextSiblingNode<cr>", desc = "Surf Next" },
        --             { "K", "<cmd>STSSelectPrevSiblingNode<cr>", desc = "Surf Prev" },
        --             { "H", "<cmd>STSSelectParentNode<cr>", desc = "Surf Parent" },
        --             { "L", "<cmd>STSSelectChildNode<cr>", desc = "Surf Child" },
        --             { "<A-j>", "<cmd>STSSwapNextVisual<cr>", desc = "Surf Swap Next" },
        --             { "<A-k>", "<cmd>STSSwapPrevVisual<cr>", desc = "Surf Swap Prev" },
        --         },
        --     })
        -- end

        local terminal_ok, toggleterm = pcall(require, "toggleterm.terminal")
        if terminal_ok then
            local Terminal = toggleterm.Terminal
            local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

            function _LAZYGIT_TOGGLE()
                lazygit:toggle()
            end

            local node = Terminal:new({ cmd = "node", hidden = true })

            function _NODE_TOGGLE()
                node:toggle()
            end

            local htop = Terminal:new({ cmd = "htop", hidden = true })

            function _HTOP_TOGGLE()
                htop:toggle()
            end

            local python = Terminal:new({ cmd = "python", hidden = true })

            function _PYTHON_TOGGLE()
                python:toggle()
            end

            local ghci = Terminal:new({ cmd = "ghcid", hidden = true })

            function _GHCI_TOGGLE()
                ghci:toggle()
            end

            -- ToggleTerm
            wk.add({
                {
                    { "<leader>t", group = "+ToggleTerm" },
                    { "<leader>tg", _GHCI_TOGGLE, desc = "GHCi" },
                    { "<leader>th", _HTOP_TOGGLE, desc = "HTOP" },
                    { "<leader>tl", _LAZYGIT_TOGGLE, desc = "LazyGit" },
                    { "<leader>tn", _NODE_TOGGLE, desc = "Node" },
                    { "<leader>tp", _PYTHON_TOGGLE, desc = "Python" },
                    { "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Term" },
                },
            })
        end
        wk.add({
            { "<leader>r", group = "+Rest" },
            { "<leader>rr", "<cmd>Rest run<CR>", desc = "Run" },
            { "<leader>rl", "<cmd>Rest run last<CR>", desc = "Rerun" },
        })

        -- Neorg
        wk.add({
            { "<leader>n", group = "+Neorg" },
            {
                { "<leader>nj", group = "+Journal" },
                { "<leader>njj", "<cmd>Neorg journal today<CR>", desc = "Today" },
                { "<leader>njm", "<cmd>Neorg journal tomorrow<CR>", desc = "Tomorrow" },
                { "<leader>njt", "<cmd>Neorg journal template<CR>", desc = "Template" },
                { "<leader>njy", "<cmd>Neorg journal yesterday<CR>", desc = "Yesterday" },
            },
            { "<leader>ni", "<cmd>Neorg index<CR>", desc = "Index" },
            { "<leader>nm", "<cmd>Neorg inject-metadata<CR>", desc = "Generate Metadata" },
            { "<leader>nr", "<cmd>Neorg return<CR>", desc = "Return" },
            { "<leader>ns", "<cmd>Neorg sync-parsers<CR>", desc = "Sync Parsers" },
            { "<leader>nt", "<cmd>Neorg toc<CR>", desc = "Table of Contents" },
            {
                { "<leader>nw", group = "+Workspace" },
                { "<leader>nwd", "<cmd>Neorg workspace default<CR>", desc = "Default" },
                { "<leader>nwh", "<cmd>Neorg workspace home<CR>", desc = "Home" },
                { "<leader>nwj", "<cmd>Neorg workspace work<CR>", desc = "Work" },
                { "<leader>nws", "<cmd>Neorg generate-workspace-summary<CR>", desc = "Summary" },
                { "<leader>nww", "<cmd>Neorg workspace<CR>", desc = "Select" },
            },
        })

        wk.add({
            { "<leader>u", group = "+Neotest" },
            { "<leader>ua", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach Nearest" },
            {
                "<leader>ud",
                "<cmd>lua require('neotest').run.attach({ strategy = 'dap' })<cr>",
                desc = "Debug Nearest",
            },
            { "<leader>uf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test File" },
            { "<leader>uo", "<cmd>lua require('neotest').output_panel.toggle()<cr>", desc = "Toggle Output" },
            { "<leader>us", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop Nearest" },
            { "<leader>ut", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test Nearest" },
            { "<leader>uw", "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<cr>", desc = "Watch File" },
        })

        wk.add({ { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" } })
        wk.add({ { "<leader>o", "<cmd>Outline<cr>", desc = "Outline" } })

        wk.add({
            {
                "<leader>fs",
                function()
                    require("rip-substitute").sub()
                end,
                mode = { "n", "x" },
                desc = " rip substitute",
            },
        })

        wk.setup(opts)
    end,
    opts = {},
    --    opts = {
    --        plugins = {
    --            marks = true, -- shows a list of your marks on ' and `
    --            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    --            spelling = {
    --                enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    --                suggestions = 20, -- how many suggestions should be shown in the list?
    --            },
    --            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    --            -- No actual key bindings are created
    --            presets = {
    --                operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
    --                motions = true, -- adds help for motions
    --                text_objects = true, -- help for text objects triggered after entering an operator
    --                windows = true, -- default bindings on <c-w>
    --                nav = true, -- misc bindings to work with windows
    --                z = true, -- bindings for folds, spelling and others prefixed with z
    --                g = true, -- bindings for prefixed with g
    --            },
    --        },
    --        icons = {
    --            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    --            separator = "➜", -- symbol used between a key and it's label
    --            group = "+", -- symbol prepended to a group
    --        },
    --        layout = {
    --            height = { min = 4, max = 25 }, -- min and max height of the columns
    --            width = { min = 20, max = 50 }, -- min and max width of the columns
    --            spacing = 3, -- spacing between columns
    --            align = "left", -- align columns left, center or right
    --        },
    --        -- show_help = true, -- show help message on the command line when the popup is visible
    --        -- triggers = "auto", -- automatically setup triggers
    --        -- triggers = { "<leader>" }, -- or specify a list manually
    --        -- disable the WhichKey popup for certain buf types and file types.
    --        -- Disabled by deafult for Telescope
    --        disable = {
    --            buftypes = {},
    --            filetypes = { "TelescopePrompt" },
    --        },
    --    },
}
