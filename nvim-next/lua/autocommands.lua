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

-- Persistent Folds
-- local save_fold = vim.api.nvim_create_augroup("Persistent Folds", { clear = true })
-- vim.api.nvim_create_autocmd("BufWinLeave", {
--     pattern = "*.*",
--     callback = function()
--         vim.cmd.mkview()
--     end,
--     group = save_fold,
-- })
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--     pattern = "*.*",
--     callback = function()
--         vim.cmd.loadview({ mods = { emsg_silent = true } })
--     end,
--     group = save_fold,
-- })

local lua_folds = vim.api.nvim_create_augroup("Fix Lua Folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*.lua",
    command = "set foldlevel=99",
    group = lua_folds,
})

local neogit_commit_fix = vim.api.nvim_create_augroup("neogit-additions", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = neogit_commit_fix,
    pattern = "NeogitCommitMessage",
    command = "silent! set filetype=gitcommit",
})

-- yankring
local yank_ring = vim.api.nvim_create_augroup("yank-ring", { clear = false })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_ring,
    callback = function()
        if vim.v.event.operator == "y" then
            for i = 9, 1, -1 do -- Shift all numbered registers.
                vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
            end
        end
    end,
})
