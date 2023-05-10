local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
    return
end

local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local uReload = require("utils").reload
local print = require("utils").print

telescope.setup({
    picker = {
        hidden = false,
    },
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
            -- one of these two causes a major slowdown, probably hidden
            -- "--no-ignore",
            -- "--hidden",
        },
        prompt_prefix = "     ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        dynamic_preview_title = true,
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.80,
            height = 0.85,
            preview_cutoff = 120,
        },
        file_sorter = sorters.get_fuzzy_file,
        file_ignore_patterns = { "node_modules", ".git/", "dist/" },
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        path_display = {
            shorten = {
                len = 3,
                exclude = { -1 },
            },
        },
        winblend = 0,
        border = {},
        borderchars = { "" },
        color_devicons = true,
        use_less = false,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        buffer_previewer_maker = previewers.buffer_previewer_maker,
        mappings = {
            i = {
                ["<c-n>"] = actions.cycle_history_next,
                ["<c-p>"] = actions.cycle_history_prev,
                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,
                ["<c-q>"] = actions.send_to_qflist,
            },
        },
    },
    pickers = {
        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
                i = {
                    ["<c-d>"] = "delete_buffer",
                },
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})
telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")
telescope.load_extension("fzf")
telescope.load_extension("notify")
telescope.load_extension("hoogle")
telescope.load_extension("harpoon")
telescope.load_extension("git_worktree")
telescope.load_extension("ht")
--[[ telescope.load_extension("yank_history") ]]
--[[ telescope.load_extension("noice") ]]

local M = {}

function M.reload()
    -- Telescope will give us something like ju/colors.lua,
    -- so this function convert the selected entry to
    -- the module name: ju.colors
    local function get_module_name(s)
        local module_name

        module_name = s:gsub("%.lua", "")
        module_name = module_name:gsub("%/", ".")
        module_name = module_name:gsub("%.init", "")

        return module_name
    end

    local prompt_title = "~ neovim modules ~"

    -- sets the path to the lua folder
    local path = "~/.config/nvim/lua"

    local opts = {
        prompt_title = prompt_title,
        cwd = path,

        attach_mappings = function(_, m)
            -- Adds a new map to ctrl+e.
            m("i", "<c-e>", function(_)
                -- these two a very self-explanatory
                local entry = require("telescope.actions.state").get_selected_entry()
                local name = get_module_name(entry.value)

                -- call the helper method to reload the module
                -- and give some feedback
                uReload()
                print(name .. " RELOADED!!!")
            end)

            return true
        end,
    }

    -- call the builtin method to list files
    require("telescope.builtin").find_files(opts)
end

local dir_tele_ok, dir_tele = pcall(require, "dir-telescope")
if not dir_tele_ok then
    return
end
dir_tele.setup({
    hidden = true,
    respect_gitignore = true,
})

return M
