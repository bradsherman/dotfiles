local status_ok, beacon = pcall(require, "beacon")
if not status_ok then
    return
end

beacon.setup({
    enable = true,
    size = 40,
    fade = true,
    minimal_jump = 10,
    show_jumps = true,
    focus_gained = true,
    shrink = true,
    timeout = 200,
    ignore_buffers = {},
    ignore_filetypes = { "NeogitStatus", "NvimTree" },
})
