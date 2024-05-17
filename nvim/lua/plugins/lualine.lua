return {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    opts = function()
        local function fg(name)
            ---@type {foreground?:number}?
            local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
                or vim.api.nvim_get_hl_by_name(name, true)
            local fg1 = hl and hl.fg or hl.foreground
            return fg1 and { fg = string.format("#%06x", fg1) }
        end

        local function diff_source()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
                return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                }
            end
        end
        return {
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha" } },
            },
            sections = {
                lualine_a = { { "mode", icon = " ", separator = { left = "", right = "" } } },
                lualine_b = {
                    { "b:gitsigns_head", icon = "", separator = { left = "", right = "" } },
                    {
                        "diff",
                        source = diff_source,
                        separator = { left = "", right = "" },
                        symbols = { added = " ", modified = " ", removed = " " },
                    },
                },
                lualine_c = {
                    {
                        "diagnostics",
                        symbols = {
                            error = " ",
                            warn = " ",
                            hint = " ",
                            info = " ",
                        },
                        separator = { left = "", right = "" },
                    },
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                    {
                        function()
                            return "%="
                        end,
                        separator = "",
                    },
                    {
                        function()
                            local msg = "No Active Lsp"
                            local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                            local clients = vim.lsp.get_clients()
                            if next(clients) == nil then
                                return msg
                            end
                            local relevant_clients = {}
                            for _, client in ipairs(clients) do
                                ---@diagnostic disable-next-line: undefined-field
                                local filetypes = client.config.filetypes
                                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                    relevant_clients[client.name] = true
                                    -- why was this commented
                                    -- table.insert(relevant_clients, client.name)
                                end
                            end
                            if not next(relevant_clients) then
                                return msg
                            end
                            local client_names = {}
                            for k, _ in pairs(relevant_clients) do
                                table.insert(client_names, k)
                            end
                            return table.concat(client_names, ", ")
                        end,
                        icon = " LSP: ",
                        color = { gui = "bold" },
                        separator = "",
                    },
                },
                lualine_x = {
                    -- stylua: ignore
                    {
                        "overseer"
                    },
                    -- stylua: ignore
                    {
                    function() return require("noice").api.status.command.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                    color = fg("Statement"),
                    },
                    -- stylua: ignore
                    {
                    function() return require("noice").api.status.mode.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    color = fg("Constant"),
                    },
                    -- stylua: ignore
                    {
                    function() return "  " .. require("dap").status() end,
                    cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
                    color = fg("Debug"),
                    },
                    -- stylua: ignore
                    { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
                },
                lualine_y = {
                    { "progress", separator = " ", padding = { left = 1, right = 0 } },
                    {
                        "location",
                        icon = " ",
                        padding = { left = 0, right = 1 },
                    },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
            extensions = { "neo-tree", "lazy" },
        }
    end,
}
