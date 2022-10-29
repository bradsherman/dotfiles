local neodim_status_ok, neodim = pcall(require, "neodim")
if not neodim_status_ok then
    return
end

local nfox_ok, palettes = pcall(require, "nightfox.palette")
if not nfox_ok then
    return
end
local palette = palettes.load("nordfox")

neodim.setup({
    alpha = 0.5,
    blend_color = palette.bg0,
    update_in_insert = {
        enable = true,
        delay = 100,
    },
    hide = {
        virtual_text = true,
        signs = true,
        underline = true,
    },
})
