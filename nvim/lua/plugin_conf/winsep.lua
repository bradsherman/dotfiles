local status_ok, winsep = pcall(require, "colorful-winsep")
if not status_ok then
    return
end

winsep.setup({
    direction = {
        down = "j",
        left = "h",
        right = "l",
        up = "k",
    },
    highlight = {
        bg = "bg",
        fg = "#957CC6",
    },
    interval = 100,
    no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest" },
    symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
    win_opts = {
        relative = "editor",
        style = "minimal",
    },
})
