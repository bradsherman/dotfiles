local status_ok, leaf = pcall(require, "leaf")
if not status_ok then
    return
end
leaf.setup({
    underlineStyle = "undercurl",
    commentStyle = "italic",
    functionStyle = "italic,bold",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    transparent = false,
    colors = {},
    overrides = {},
    theme = "dark", -- "dark", "light"
    contrast = "low", -- options: "low", "medium", "high"
})
