local gh_status_ok, gh = pcall(require, "litee.gh")
if not gh_status_ok then
    return
end

gh.setup({
    icon_set = "nerd",
    jump_mode = "invoking",
    map_resize_keys = true,
    disable_keymaps = false,
    prefer_https_remote = false,
    keymaps = {
        open = "<CR>",
        expand = "zo",
        collapse = "zc",
        goto_issue = "gd",
        details = "d",
    },
})
