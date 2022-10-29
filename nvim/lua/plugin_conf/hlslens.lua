local status_ok, hlslens = pcall(require, "hlslens")
if not status_ok then
    return
end

hlslens.setup({
    auto_enable = false,
    enable_incsearch = true,
    calm_down = false,
    nearest_only = false,
    -- When to open floating window for nearest lens
    nearest_float_when = "auto", -- "auto", "always", "never"
    -- winblend of nearest floating window
    float_shadow_blend = 50,
    -- priority of virtual text
    virt_priority = 100,
    override_lens = nil,
})
