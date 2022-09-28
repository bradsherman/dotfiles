local status_ok, hlslens = pcall(require, "hlslens")
if not status_ok then
    return
end

hlslens.setup({
    auto_enable = true,
    enable_incsearch = true,
    calm_down = true,
    nearest_only = false,
    -- When to open floating window for nearest lens
    nearest_float_when = "always", -- "auto", "always", "never"
    -- winblend of nearest floating window
    float_shadow_blend = 50,
    -- priority of virtual text
    virt_priority = 100,
    override_lens = nil,
})
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

vim.api.nvim_set_keymap("n", "<Leader>l", ":noh<CR>", kopts)
