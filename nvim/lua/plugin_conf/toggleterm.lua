local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup({
    size = 25,
    open_mapping = [[<c-/>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = false,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end,
    },
})

local function set_terminal_keymaps()
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
    vim.keymap.set("t", "jk", [[<C-\><C-n>]])
    vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]])
    vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]])
    vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]])
    vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]])
end
local term_aucmd = vim.api.nvim_create_augroup("ToggleTerm", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    callback = set_terminal_keymaps,
    pattern = "term://*",
    group = term_aucmd,
})
