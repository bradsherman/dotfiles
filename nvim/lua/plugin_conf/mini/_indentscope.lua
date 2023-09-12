local status_ok, mini_indentscope = pcall(require, "mini.indentscope")
if not status_ok then
    return
end
mini_indentscope.setup({
    symbol = "│",
    options = { try_as_border = true },
})
