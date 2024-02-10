return {
    "stevearc/overseer.nvim",
    config = function(_, opts)
        local overseer = require("overseer")
        overseer.setup(opts)

        vim.api.nvim_create_user_command("OverseerRestartLast", function()
            local tasks = overseer.list_tasks({ recent_first = true })
            if vim.tbl_isempty(tasks) then
                vim.notify("No tasks found", vim.log.levels.WARN)
            else
                overseer.run_action(tasks[1], "restart")
            end
        end, {})

        vim.api.nvim_create_user_command("WatchRun", function()
            overseer.run_template({ name = "stack_build_package" }, function(task)
                if task then
                    task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })
                    local main_win = vim.api.nvim_get_current_win()
                    overseer.run_action(task, "open vsplit")
                    vim.api.nvim_set_current_win(main_win)
                else
                    vim.notify("WatchRun not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
                end
            end)
        end, {})
    end,
    opts = {
        templates = { "builtin", "user.stack_build" },
        strategy = {
            "terminal",
        },
    },
}
