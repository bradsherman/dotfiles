local status_ok, mini_files = pcall(require, "mini.files")
if not status_ok then
    return
end
mini_files.setup({
    -- Customization of explorer windows
    windows = {
        -- Maximum number of windows to show side by side
        max_number = math.huge,
        -- Whether to show preview of file/directory under cursor
        preview = false,
        -- Width of focused window
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 25,
    },
})
