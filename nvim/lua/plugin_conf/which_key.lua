local status_ok, wk = pcall(require, "which-key")
if not status_ok then
    return
end

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
            "<cmd> execute luaeval(\"require('zen-mode').toggle({ window = { width = .85 } })\")<cr>",
            "Toggle Zen Mode",
        },
    },
}, { prefix = "<leader>" })

wk.register({
    ["<leader><tab>"] = { ":b#<cr>", "Previous Buffer" },
}, {})

wk.register({
    ["<leader>e"] = { ":NvimTreeFindFile<cr>", "NvimTree Find File" },
}, {})

wk.register({
    ["<leader>fe"] = {
        "<cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>",
        "Telescope File Browser",
    },
})

-- Lsp
wk.register({
    ["<leader>l"] = {
        name = "+LSP Actions",
        a = { "<cmd>Telescope lsp_code_actions theme=cursor<cr>", "Code Actions" },
        d = { "<cmd>Telescope diagnostics<cr>", "LSP Diagnostics" },
        e = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
        f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
        h = { "<cmd>Lspsaga signature_help<cr>", "Signature Help" },
        i = { "<cmd>LspInfo<cr>", "LSP Info" },
        r = { "<cmd>lua require('renamer').rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "LSP Workspace Symbols" },
        t = { "<cmd>Telescope tags<cr>", "Tags" },
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
        s = { ":G<cr>", "Git Status" },
        b = { ":Telescope git_branches<cr>", "Git Branches" },
        g = { ":Neogit<cr>", "Neogit" },
        h = {
            name = "+Github",
            i = { "<cmd>Octo issue list<cr>", "List Issues" },
            ["pr"] = { "<cmd>Octo pr list<cr>", "List PRs" },
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
