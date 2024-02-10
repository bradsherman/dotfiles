return {
    "kndndrj/nvim-dbee",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    build = function()
        -- Install tries to automatically detect the install method.
        -- if it fails, try calling it with one of these parameters:
        --    "curl", "wget", "bitsadmin", "go"
        require("dbee").install("go")
    end,
    config = function()
        require("dbee").setup({
            sources = {
                require("dbee.sources").MemorySource:new({
                    {
                        name = "Local Exchange",
                        type = "postgres",
                        url = "postgresql://app:password123@127.0.0.1:5432/main?sslmode=disable",
                    },
                    {
                        name = "Local Fcm",
                        type = "postgres",
                        url = "postgresql://app-fcm:password123@127.0.0.1:5432/fcm?sslmode=disable",
                    },
                }),
            },
            editor = {
                -- mappings for the buffer
                mappings = {
                    -- run what's currently selected on the active connection
                    { key = "<leader>rs", mode = "v", action = "run_selection" },
                    -- run the whole file on the active connection
                    { key = "<leader>ra", mode = "n", action = "run_file" },
                },
            },
        })
    end,
}
