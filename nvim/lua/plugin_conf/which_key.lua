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
    ["<leader>gd"] = { "<cmd>GrepInDirectory<cr>", "Search In Directory" },
    ["<leader>fh"] = {
        "<cmd>lua require('telescope.builtin').live_grep({glob_pattern='*.hs'})<cr>",
        "Search Haskell Files",
    },
    ["<leader>ft"] = {
        "<cmd>lua require('telescope.builtin').live_grep({glob_pattern='*.ts,*.js,*.tsx,*.jsx,*.css,*.scss'})<cr>",
        "Search Web Files",
    },
    ["<leader>ff"] = { "<cmd>FileInDirectory<cr>", "File In Directory" },
    ["<leader>fg"] = {
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
        "Live Grep Args",
    },
    ["<leader>fe"] = {
        "<cmd>require('telescope').extensions.file_browser.file_browser()<cr>",
        "Telescope File Browser",
    },
    ["<leader>f?"] = {
        "<cmd>lua require('notify').notify(vim.fn.expand('%f'))<cr>",
        "What file am I?",
    },
    ["<leader>qr"] = { "<cmd>lua require('plugin_conf/telescope').reload()<cr>", "Reload Modules" },
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
        D = { "<cmd>Lspsaga peek_definition<cr>", "Preview Definitions" },
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
        l = { "<cmd>Gitsigns blame_line<cr>", "Blame Line" },
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

-- Debug
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
            f = {
                "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>",
                "Float",
            },
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

-- Yanky
--[[ wk.register({ ]]
--[[     y = { ]]
--[[         name = "Yanky", ]]
--[[         h = { "<cmd>Telescope yank_history<cr>", "History" }, ]]
--[[         p = { "<Plug>(YankyPutAfter)", "Paste" }, ]]
--[[         P = { "<Plug>(YankyPutBefore)", "Paste Before" }, ]]
--[[         ["gp"] = { "<Plug>(YankyGPutAfter)", "Paste & Move Cursor" }, ]]
--[[         ["gP"] = { "<Plug>(YankyGPutBefore)", "Paste Before & Move Cursor" }, ]]
--[[         ["<c-n>"] = { "<Plug>(YankyCycleForward)", "Cycle Forward" }, ]]
--[[         ["<c-p>"] = { "<Plug>(YankyCycleBackward)", "Cycle Backward" }, ]]
--[[     }, ]]
--[[ }, { prefix = "<leader>", mode = "n" }) ]]

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

local hlslens_ok, _ = pcall(require, "hlslens")
if hlslens_ok then
    local kopts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
    )
    vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
    )
    vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
end

wk.setup({
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by deafult for Telescope
    disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
    },
})
