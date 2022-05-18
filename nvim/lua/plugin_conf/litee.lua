local status_ok, liteeLib = pcall(require, "litee.lib")
if not status_ok then
    return
end

liteeLib.setup({
    tree = {
        icon_set = "nerd", -- can be "codicons", "nerd"
    },
    panel = {
        orientation = "right",
        panel_size = 50,
    },
})
