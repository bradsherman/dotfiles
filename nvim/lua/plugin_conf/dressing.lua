local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
    return
end
dressing.setup({
    input = { relative = "editor" },
    select = {
        backend = { "telescope", "fzf", "builtin" },
    },
})
