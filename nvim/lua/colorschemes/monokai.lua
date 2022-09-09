local status_ok, monokai = pcall(require, "monokai")
if not status_ok then
    return
end

-- monokai.setup({})
-- monokai.setup({ palette = monokai.pro })
-- monokai.setup({ palette = monokai.soda })
monokai.setup({ palette = monokai.ristretto })
