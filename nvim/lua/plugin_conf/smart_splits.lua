local status_ok, splits = pcall(require, "smart-splits")
if not status_ok then
    return
end

splits.setup({
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = {
        "nofile",
        "quickfix",
        "prompt",
    },
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = { "NvimTree" },
    -- when moving cursor between splits left or right,
    -- place the cursor on the same row of the *screen*
    -- regardless of line numbers. False by default.
    -- Can be overridden via function parameter, see Usage.
    move_cursor_same_row = false,
    -- resize mode options
    resize_mode = {
        -- key to exit persistent resize mode
        quit_key = "<ESC>",
        -- keys to use for moving in resize mode
        -- in order of left, down, up' right
        resize_keys = { "h", "j", "k", "l" },
        -- set to true to silence the notifications
        -- when entering/exiting persistent resize mode
        silent = false,
        -- must be functions, they will be executed when
        -- entering or exiting the resize mode
        hooks = {
            on_enter = nil,
            on_leave = nil,
        },
    },
})
