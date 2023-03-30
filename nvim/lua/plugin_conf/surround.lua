local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
    return
end

local utils_status_ok, surround_utils = pcall(require, "nvim-surround.config")
if not utils_status_ok then
    return
end

surround.setup({
    keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
    },
    aliases = {
        ["a"] = ">",
        ["b"] = ")",
        ["B"] = "}",
        ["r"] = "]",
        ["q"] = { '"', "'", "`" },
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
    highlight = {
        duration = 0,
    },
    move_cursor = "begin",
    indent_lines = function(start_row, end_row)
        if start_row ~= end_row then
            surround_utils.default_opts.indent_lines(start_row, end_row)
        end
    end,
})
