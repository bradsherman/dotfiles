return {
    "windwp/nvim-autopairs",
    config = function(_, opts)
        local npairs = require("nvim-autopairs")
        npairs.setup(opts)
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if cmp_status_ok then
            -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
            -- If you want insert `(` after select function or method item
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end,
    opts = {
        check_ts = true,
        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    },
}
