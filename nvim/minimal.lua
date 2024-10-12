local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

local opts = {
    ui = {
        size = {
            width = 0.8,
            height = 0.8,
        },
    },
    change_detection = { notify = false },
}

lazy.setup({
    {
        "sindrets/diffview.nvim",
        opts = {
            use_icons = false,
            file_panel = {
                win_config = {
                    position = "right",
                    width = 25,
                },
            },
        },
    },
}, opts)

return {}
