local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
    return
end

trouble.setup({
    auto_close = true,
    signs = {
        error = "❌",
        warning = "⚠️ ",
        hint = "💡",
        information = "ℹ️ ",
        other = "✔️ ",
    },
})
