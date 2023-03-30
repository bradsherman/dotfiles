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

-- Trim whitespace on save
local ws = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", { command = "%s/\\s\\+$//e", group = ws })

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

local ht = vim.api.nvim_create_augroup("HaskellTabs", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "haskell",
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
        vim.highlight.on_yank()
    end,
    group = highlight_group,
})

-- Fix folding on telescope find files
-- Info here: https://github.com/nvim-telescope/telescope.nvim/issues/699
-- Just do popular filetypes until this is fixed
local fold_fix_group = vim.api.nvim_create_augroup("FixFolding", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    --[[ pattern = { "*.hs", "*.lua", "*.ts", "*.js", "*.tsx", "*.jsx", "*.json" }, ]]
    pattern = { "*" },
    command = "normal zx",
    group = fold_fix_group,
})
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

-- vim.api.nvim_create_autocmd({ "BufReadPost,FileReadPost" }, {
--     pattern = { "*" },
--     command = "normal zR",
--     -- group = fold_fix_group,
-- })
