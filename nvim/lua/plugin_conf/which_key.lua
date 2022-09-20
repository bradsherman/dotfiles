local status_ok, wk = pcall(require, "which-key")
if not status_ok then
    return
end

local show = wk.show
wk.show = function(keys, opts)
    if vim.bo.filetype == "TelescopePrompt" then
        local map = "<c-r>"
        local key = vim.api.nvim_replace_termcodes(map, true, false, true)
        vim.api.nvim_feedkeys(key, "i", true)
    end
    show(keys, opts)
end

local update_haskell_tags = require("utils").update_haskell_tags

-- Miscellaneous Telescope mappings
wk.register({
    ["<c-f>"] = { "<cmd>Telescope find_files<cr>", "Telescope Files" },
    ["<c-g>"] = { "<cmd>Telescope live_grep<cr>", "Telescope Grep" },
    ["<c-b>"] = { "<cmd>Telescope buffers<cr>", "Telescope Buffers" },
    ["<leader>fe"] = {
        "<cmd>require('telescope').extensions.file_browser.file_browser()<cr>",
        "Telescope File Browser",
    },
    ["<leader>qr"] = { "<cmd>require('plugin_conf/telescope').reload()<cr>", "Reload Modules" },
    ["<leader>bd"] = { "<cmd>%bd|e#<cr>", "Clear Buffers" },
}, {})

-- Quickfix
wk.register({
    q = {
        name = "+Quickfix",
        j = { "<cmd>cnext<cr>", "Quickfix next" },
        k = { "<cmd>cprev<cr>", "Quickfix prev" },
        c = { "<cmd>copen<cr>", "Quickfix open" },
        q = { "<cmd>cclose<cr>", "Quickfix close" },
    },
}, { prefix = "<leader>" })

-- Colorizer
wk.register({
    c = {
        name = "+Colorizer",
        t = { "<cmd>ColorizerToggle<cr>", "Toggle Colorizer" },
    },
}, { prefix = "<leader>" })

-- Markdown Preview
wk.register({
    ["m"] = {
        name = "+Markdown",
        p = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
        s = { "<cmd>MarkdownPreviewStop<cr>", "Markdown Preview Stop" },
        t = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview Toggle" },
    },
}, { prefix = "<leader>" })

-- Packer
wk.register({
    p = {
        name = "+Packer",
        c = { "<cmd>PackerCompile<cr>", "Packer Compile" },
        i = { "<cmd>PackerInstall<cr>", "Packer Install" },
        u = { "<cmd>PackerSync<cr>", "Packer Sync" },
    },
}, { prefix = "<leader>" })

-- Zen Mode
wk.register({
    z = {
        name = "ZenMode",
        m = {
            "<cmd>ZenMode<cr>",
            "Toggle Zen Mode",
        },
        t = {
            "<cmd>Twilight<cr>",
            "Toggle Twilight",
        },
    },
}, { prefix = "<leader>" })

-- Misc
wk.register({
    ["<tab>"] = { "<cmd>b#<cr>", "Previous Buffer" },
    ["tm"] = { "<cmd>TableModeToggle<cr>", "Toggle TableMode" },
    ["sw"] = { "<cmd>set list!<cr>", "Show Whitespace Chars" },
    ["se"] = { "<cmd>Eswpoch<cr>", "Epoch Switcher" },
    ["fe"] = {
        "<cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>",
        "Telescope File Browser",
    },
    ["nc"] = { "<cmd>lua require('notify').dismiss({pending = true})<cr>", "Clear Notifications" },
}, { prefix = "<leader>" })

wk.register({
    f = {
        name = "+DiffView",
        o = { "<cmd>DiffviewOpen<cr>", "Diffview Open" },
        h = { "<cmd>DiffviewOpen HEAD~1<cr>", "Diffview Open Last Commit" },
        c = { "<cmd>DiffviewClose<cr>", "Diffview Close" },
        f = { "<cmd>DiffviewFileHistory %<cr>", "Diffview File History" },
    },
}, { prefix = "<leader>d" })

wk.register({
    ["<leader>e"] = { "<cmd>Neotree toggle reveal<cr>", "Neotree Find File" },
    ["<C-e>"] = { "<cmd>Neotree toggle<cr>", "Neotree Toggle" },
}, {})

wk.register({
    e = { "<cmd>Neotree toggle<cr>", "Neotree Toggle" },
    d = { "<cmd>Neotree diagnostics toggle bottom<cr>", "Neotree Diagnostics" },
}, { prefix = "<leader>n" })

-- wk.register({
--     ["<leader>e"] = { "<cmd>NvimTreeFindFile<cr>", "NvimTree Find File" },
--     ["<C-e>"] = { "<cmd>NvimTreeToggle<cr>", "NvimTree Toggle" },
-- }, {})

-- Lsp
wk.register({
    ["<leader>l"] = {
        name = "+LSP Actions",
        a = { "<cmd>Lspsaga code_action<cr>", "Code Actions" },
        d = { "<cmd>Telescope diagnostics<cr>", "LSP Diagnostics" },
        e = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
        h = { "<cmd>Lspsaga signature_help<cr>", "Signature Help" },
        i = { "<cmd>LspInfo<cr>", "LSP Info" },
        p = { "<cmd>TroubleToggle<cr>", "LSP Trouble" },
        r = { "<cmd>IncRename " .. vim.fn.expand("<cword>") .. "<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "LSP Workspace Symbols" },
        t = { "<cmd>Telescope tags<cr>", "Tags" },
        u = { update_haskell_tags, "Update Haskell tags" },
    },
    g = {
        name = "+LSP Types",
        d = { "<cmd>Telescope lsp_definitions<cr>", "Definitions" },
        D = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definitions" },
        i = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
        K = { "<cmd>Lspsaga hover_doc<cr>", "Hover Doc" },
        m = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        r = { "<cmd>Telescope lsp_references<cr>", "References" },
        t = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Definitions" },
    },
}, {})

-- Git
wk.register({
    g = {
        name = "+Git",
        -- Fugitive
        s = { "<cmd>G<cr>", "Git Status" },
        -- Telescope
        b = { "<cmd>Telescope git_branches<cr>", "Git Branches" },
        -- Neogit
        g = { "<cmd>Neogit<cr>", "Neogit" },
        c = {
            name = "+Conflict",
            b = { "<cmd>GitConflictChooseBoth<cr>", "Choose Both" },
            j = { "<cmd>GitConflictNextConflict<cr>", "Next Conflict" },
            k = { "<cmd>GitConflictPrevConflict<cr>", "Previous Conflict" },
            l = { "<cmd>GitConflictListQf<cr>", "To Quickfix" },
            n = { "<cmd>GitConflictChooseNone<cr>", "Choose None" },
            o = { "<cmd>GitConflictChooseOurs<cr>", "Choose Ours" },
            t = { "<cmd>GitConflictChooseTheirs<cr>", "Choose Theirs" },
        },
        h = {
            name = "+Github",
            c = {
                name = "+Commits",
                c = { "<cmd>GHCloseCommit<cr>", "Close" },
                e = { "<cmd>GHExpandCommit<cr>", "Expand" },
                o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
                p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
                z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
            },
            d = { "<cmd>GHOpenDebugBuffer<cr>", "Open Debug Buffer" },
            i = {
                name = "+Issues",
                l = { "<cmd>Octo issue list<cr>", "List Issues (Octo)" },
                p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
            },
            l = {
                name = "+Litee/Labels",
                a = { "<cmd>GHAddLabel<cr>", "Add Label to PR" },
                r = { "<cmd>GHRemoveLabel<cr>", "Remove Label to PR" },
                t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
            },
            r = {
                name = "+Review",
                b = { "<cmd>GHStartReview<cr>", "Begin" },
                c = { "<cmd>GHCloseReview<cr>", "Close" },
                d = { "<cmd>GHDeleteReview<cr>", "Delete" },
                e = { "<cmd>GHExpandReview<cr>", "Expand" },
                s = { "<cmd>GHSubmitReview<cr>", "Submit" },
                z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
            },
            p = {
                name = "+Pull Request",
                c = { "<cmd>GHClosePR<cr>", "Close" },
                d = { "<cmd>GHPRDetails<cr>", "Details" },
                e = { "<cmd>GHExpandPR<cr>", "Expand" },
                l = { "<cmd>Octo pr list<cr>", "List (Octo)" },
                m = { "<cmd>GHRequestedReview<cr>", "My PRs To Review" },
                o = { "<cmd>GHOpenPR<cr>", "Open" },
                p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
                r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
                s = { "<cmd>GHSearchPRs<cr>", "Search All PRs" },
                t = { "<cmd>GHOpenToPR<cr>", "Open To" },
                z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
            },
            t = {
                name = "+Threads",
                c = { "<cmd>GHCreateThread<cr>", "Create" },
                n = { "<cmd>GHNextThread<cr>", "Next" },
                t = { "<cmd>GHToggleThreads<cr>", "Toggle" },
            },
        },
        n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
        p = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
        d = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
        w = {
            name = "+Worktree",
            c = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", "Create" },
            s = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", "Switch" },
        },
    },
}, { prefix = "<leader>" })

wk.register({
    d = {
        name = "Debug",
        s = {
            name = "Step",
            c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
            v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
            i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
            o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
        },
        h = {
            name = "Hover",
            h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
            v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
        },
        u = {
            name = "UI",
            h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
            f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Float" },
        },
        r = {
            name = "Repl",
            o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
            l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
        },
        b = {
            name = "Breakpoints",
            c = {
                "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                "Breakpoint Condition",
            },
            m = {
                "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
                "Log Point Message",
            },
            t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
        },
        c = { "<cmd>lua require('dap').scopes()<CR>", "Scopes" },
        i = { "<cmd>lua require('dap').toggle()<CR>", "Toggle" },
    },
}, { prefix = "<leader>" })

-- Syntax Tree Surfer
local surfer_ok, _ = pcall(require, "syntax-tree-surfer")
if surfer_ok then
    local swapper = function(cmd)
        vim.opt.opfunc = cmd
        return "g@l"
    end
    wk.register({
        v = {
            name = "Syntax Tree Surfer Swapping",
            -- d = { "<cmd>lua require('syntax-tree-surfer').move('n', false)<cr>", "Continue" },
            d = {
                function()
                    swapper("v:lua.STSSwapCurrentNodeNextNormal_Dot")
                end,
                "Swap Current Next",
            },
            D = {
                function()
                    swapper("v:lua.STSSwapDownNormal_Dot")
                end,
                "Swap Master Next",
            },
            u = {
                function()
                    swapper("v:lua.STSSwapCurrentNodePrevNormal_Dot")
                end,
                "Swap Current Prev",
            },
            U = {
                function()
                    swapper("v:lua.STSSwapUpNormal_Dot")
                end,
                "Swap Master Prev",
            },
            -- u = { "<cmd>lua require('syntax-tree-surfer').move('n', true)<cr>", "Previous" },
            -- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
            x = { "<cmd>STSSelectMasterNode<cr>", "Select" },
            -- .select_current_node() will select the current node at your cursor
            n = { "<cmd>STSSelectCurrentNode<cr>", "Select Current" },
            -- o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
        },
    }, { mode = "n" })

    wk.register({
        J = { "<cmd>STSSelectNextSiblingNode<cr>", "Surf Next" },
        K = { "<cmd>STSSelectPrevSiblingNode<cr>", "Surf Prev" },
        H = { "<cmd>STSSelectParentNode<cr>", "Surf Parent" },
        L = { "<cmd>STSSelectChildNode<cr>", "Surf Child" },
        ["<A-j>"] = { "<cmd>STSSwapNextVisual<cr>", "Surf Swap Next" },
        ["<A-k>"] = { "<cmd>STSSwapPrevVisual<cr>", "Surf Swap Prev" },
    }, { mode = "x" })
end

-- Harpoon
wk.register({
    h = {
        name = "Harpoon",
        a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add File" },
        m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle Menu" },
        j = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Next" },
        k = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Previous" },
    },
}, { prefix = "<leader>" })

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
    wk.register({
        t = {
            name = "+ToggleTerm",
            g = { _GHCI_TOGGLE, "GHCi" },
            h = { _HTOP_TOGGLE, "HTOP" },
            l = { _LAZYGIT_TOGGLE, "LazyGit" },
            n = { _NODE_TOGGLE, "Node" },
            p = { _PYTHON_TOGGLE, "Python" },
            t = { "<cmd>ToggleTerm<cr>", "Toggle Term" },
        },
    }, { prefix = "<leader>" })
end

wk.setup()
