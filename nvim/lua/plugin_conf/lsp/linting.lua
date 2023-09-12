local status_ok, lint = pcall(require, "lint")
if not status_ok then
    return
end

lint.linters_by_ft = {
    sh = { "shellcheck" },
    -- haskell = { "hlint" },
    lua = { "selene" },
    nix = { "nixfmt" },
}

local web_languages = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
}
for _, name in pairs(web_languages) do
    if not lint.linters_by_ft[name] then
        lint.linters_by_ft[name] = { "eslint_d" }
    end
    if not vim.tbl_contains(lint.linters_by_ft[name], "eslint_d") then
        table.insert(lint.linters_by_ft[name], "eslint_d")
    end
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        lint.try_lint()
    end,
})
