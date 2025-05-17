return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            { "ivy", "borderless-full" },
            keymap = {
                fzf = {
                    ["ctrl-q"] = "select-all+accept",
                },
            },
        })
    end,
}
