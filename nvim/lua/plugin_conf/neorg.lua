local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
    return
end
neorg.setup({
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.gtd.base"] = {
            config = {
                workspace = "work",
            },
        },
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    home = "~/neorg/home",
                    work = "~/neorg/work",
                },
            },
        },
        ["core.norg.journal"] = {},
        ["core.integrations.telescope"] = {},
    },
})
