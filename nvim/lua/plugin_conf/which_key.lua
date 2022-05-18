local status_ok, wk = pcall(require, "which-key")
if not status_ok then
    return
end

local update_haskell_tags = require("utils").update_haskell_tags

-- Quickfix
wk.register({
    c = {
        name = "+Quickfix",
        j = { ":cnext<cr>", "Quickfix next" },
        k = { ":cprev<cr>", "Quickfix prev" },
        c = { ":copen<cr>", "Quickfix open" },
        q = { ":cclose<cr>", "Quickfix close" },
    },
}, { prefix = "<leader>" })

-- Packer
wk.register({
    p = {
        name = "+Packer",
        i = { ":PackerInstall<cr>", "Packer Install" },
        u = { ":PackerSync<cr>", "Packer Sync" },
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

wk.register({
    ["<leader><tab>"] = { ":b#<cr>", "Previous Buffer" },
}, {})

wk.register({
    ["<leader>to"] = { "<cmd>ToggleTerm<cr>", "Toggle Term" },
}, {})

wk.register({
    ["<leader>tl"] = { ":set list!<cr>", "Show Whitespace Chars" },
})

wk.register({
    ["<leader>e"] = { ":NvimTreeFindFile<cr>", "NvimTree Find File" },
}, {})

wk.register({
    ["<leader>fe"] = {
        "<cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>",
        "Telescope File Browser",
    },
})

wk.register({
    ["<leader>nc"] = { "<cmd>lua require('notify').dismiss({pending = true})<cr>", "Clear Notifications" },
}, {})

-- Lsp
wk.register({
    ["<leader>l"] = {
        name = "+LSP Actions",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Actions" },
        d = { "<cmd>Telescope diagnostics<cr>", "LSP Diagnostics" },
        e = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
        h = { "<cmd>Lspsaga signature_help<cr>", "Signature Help" },
        i = { "<cmd>LspInfo<cr>", "LSP Info" },
        r = { "<cmd>lua require('renamer').rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "LSP Workspace Symbols" },
        t = { "<cmd>Telescope tags<cr>", "Tags" },
        u = { update_haskell_tags, "Update tags" },
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
        s = { ":G<cr>", "Git Status" },
        -- Telescope
        b = { ":Telescope git_branches<cr>", "Git Branches" },
        -- Neogit
        g = { ":Neogit<cr>", "Neogit" },
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
            i = {
                name = "+Issues",
                l = { "<cmd>Octo issue list<cr>", "List Issues (Octo)" },
                p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
            },
            l = {
                name = "+Litee",
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
                o = { "<cmd>GHOpenPR<cr>", "Open" },
                p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
                r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
                t = { "<cmd>GHOpenToPR<cr>", "Open To" },
                z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
            },
            t = {
                name = "+Threads",
                c = { "<cmd>GHCreateThread<cr>", "Create" },
                n = { "<cmd>GHNextThread<cr>", "Next" },
                t = { "<cmd>GHToggleThread<cr>", "Toggle" },
            },
        },
        n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
        p = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
        d = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
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
    wk.register({
        v = {
            name = "Syntax Tree Surfer Swapping",
            d = { "<cmd>lua require('syntax-tree-surfer').move('n', false)<cr>", "Continue" },
            u = { "<cmd>lua require('syntax-tree-surfer').move('n', true)<cr>", "Previous" },
            -- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
            x = { "<cmd>lua require('syntax-tree-surfer').select()<cr>", "Select" },
            -- .select_current_node() will select the current node at your cursor
            n = { "<cmd>lua require('syntax-tree-surfer').select_current_node()<cr>", "Select Current" },
            o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
        },
    }, { mode = "n" })

    wk.register({
        J = { "<cmd>lua require('syntax-tree-surfer').surf('next', 'visual')<cr>", "Surf Next" },
        K = { "<cmd>lua require('syntax-tree-surfer').surf('prev', 'visual')<cr>", "Surf Prev" },
        H = { "<cmd>lua require('syntax-tree-surfer').surf('parent', 'visual')<cr>", "Surf Parent" },
        L = { "<cmd>lua require('syntax-tree-surfer').surf('child', 'visual')<cr>", "Surf Child" },
        ["<A-j>"] = { "<cmd>lua require('syntax-tree-surfer').surf('next', 'visual', true)<cr>", "Surf Swap Next" },
        ["<A-k>"] = { "<cmd>lua require('syntax-tree-surfer').surf('prev', 'visual', true)<cr>", "Surf Swap Prev" },
    }, { mode = "x" })
end
