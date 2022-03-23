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
        vim.cmd("setlocal spell textwidth=90")
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

-- auto format on save
local fs = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    command = "lua vim.lsp.buf.formatting_sync(nil,1000)",
    group = fs,
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
