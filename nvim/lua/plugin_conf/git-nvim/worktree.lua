local status_ok, wt = pcall(require, "git-worktree")
if not status_ok then
    return
end

wt.setup({
    change_directory_command = "cd",
    update_on_change = true,
    update_on_change_command = "Neogit",
    clearjumps_on_change = true,
    autopush = false,
})

-- local status_ok, wt = pcall(require, "worktrees")
-- if not status_ok then
--     return
-- end
--
-- wt.setup()
