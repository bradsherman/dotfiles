local neotree_status_ok, neotree = pcall(require, "neo-tree")
if not neotree_status_ok then
    return
end

neotree.setup({
    event_handlers = {
        {
            event = "file_opened",
            handler = function()
                -- auto close
                require("neo-tree").close_all()
            end,
        },
        {
            event = "file_renamed",
            handler = function(args)
                -- fix references to file
                print(args.source, " renamed to ", args.destination)
            end,
        },
        {
            event = "file_moved",
            handler = function(args)
                -- fix references to file
                print(args.source, " moved to ", args.destination)
            end,
        },
        {
            event = "neo_tree_buffer_enter",
            handler = function()
                vim.cmd("highlight! Cursor blend=100")
            end,
        },
        {
            event = "neo_tree_buffer_leave",
            handler = function()
                vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
            end,
        },
    },
    window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
        -- possible options. These can also be functions that return these options.
        position = "right", -- left, right, float, current
        width = 60, -- applies to left and right positions
    },
    sources = {
        "filesystem",
        "buffers",
        "git_status",
        "diagnostics",
    },
})
