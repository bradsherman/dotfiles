local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
    return
end
neogit.setup({
    disable_context_highlighting = true,
    disable_commit_confirmation = true,
    disable_hint = true,
    integrations = {
        diffview = true,
    },
    signs = {
        section = { " ", " " },
        item = { " ", " " },
        hunk = { "", "" },
    },
})
