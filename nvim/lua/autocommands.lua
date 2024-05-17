local md = vim.api.nvim_create_augroup("Markdown", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.md",
    callback = function()
        vim.cmd("set ft=markdown")
        vim.cmd("set wrap")
    end,
    group = md,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.cmd("set conceallevel=2")
        vim.cmd("setlocal spell spelllang=en")
        vim.cmd("setlocal spell textwidth=120")
    end,
    group = md,
})

local norg = vim.api.nvim_create_augroup("Norg", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.norg",
    callback = function()
        vim.cmd("set wrap")
        vim.cmd("set spell spelllang=en")
        vim.cmd("setlocal spell textwidth=120")
    end,
    group = norg,
})

-- Return to last edit position when opening a file
local ep = vim.api.nvim_create_augroup("ResumeEditPosition", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    command = 'if line("\'\\"") > 1 && line("\'\\"") <= line("$") && &ft !~# \'gitcommit\' | execute "normal! g`\\"" | endif',
    group = ep,
})

local cm = vim.api.nvim_create_augroup("CommitMsg", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitcommit",
    command = "setlocal spell textwidth=72",
    group = cm,
})

local ht = vim.api.nvim_create_augroup("Bigger Tabs", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "haskell", "lua" },
    callback = function()
        vim.cmd("setlocal tabstop=4")
        vim.cmd("setlocal softtabstop=4")
        vim.cmd("setlocal shiftwidth=4")
    end,
    group = ht,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
    group = highlight_group,
})

-- Fix folding on telescope find files
-- Info here: https://github.com/nvim-telescope/telescope.nvim/issues/699
-- Just do popular filetypes until this is fixed
-- local fold_fix_group = vim.api.nvim_create_augroup("FixFolding", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     --[[ pattern = { "*.hs", "*.lua", "*.ts", "*.js", "*.tsx", "*.jsx", "*.json" }, ]]
--     pattern = { "*" },
--     command = "set foldexpr=nvim_treesitter#foldexpr()", --"normal zx zR",
--     group = fold_fix_group,
-- })

-- Persistent Folds
local save_fold = vim.api.nvim_create_augroup("Persistent Folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "*.*",
    callback = function()
        vim.cmd.mkview()
    end,
    group = save_fold,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*.*",
    callback = function()
        vim.cmd.loadview({ mods = { emsg_silent = true } })
    end,
    group = save_fold,
})

local lua_folds = vim.api.nvim_create_augroup("Fix Lua Folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*.lua",
    command = "set foldlevel=99",
    group = lua_folds,
})

-- https://github.com/nvim-telescope/telescope.nvim/issues/2027
-- local telescope_fix = vim.api.nvim_create_augroup("FixTelescopeMode", { clear = true })
-- vim.api.nvim_create_autocmd( -- Prevent entering buffers in insert mode.
--     "WinLeave",
--     {
--         callback = function()
--             if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
--                 vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
--             end
--         end,
--         group = telescope_fix,
--     }
-- )

local neogit_commit_fix = vim.api.nvim_create_augroup("neogit-additions", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = neogit_commit_fix,
    pattern = "NeogitCommitMessage",
    command = "silent! set filetype=gitcommit",
})
