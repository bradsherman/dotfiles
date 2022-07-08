local dim_status_ok, dim = pcall(require, "dim")
if not dim_status_ok then
    return
end

local dim_config = {
    disable_lsp_decorations = false, -- disable virt text and underline by lsp on unused vars and functions
}

local neodim_status_ok, neodim = pcall(require, "neodim")
if not neodim_status_ok then
    return
end

local nfox_ok, palettes = pcall(require, "nightfox.palette")
if not nfox_ok then
    return
end
local palette = palettes.load("nordfox")

local neodim_config = {
    alpha = 0.5,
    blend_color = palette.bg0,
    update_in_insert = {
        enable = true,
        delay = 100,
    },
    hide = {
        virtual_text = true,
        signs = false,
        underline = true,
    },
}

local use_neodim = true

if use_neodim and neodim_status_ok then
    neodim.setup(neodim_config)
elseif not use_neodim and dim_status_ok then
    dim.setup(dim_config)
end
