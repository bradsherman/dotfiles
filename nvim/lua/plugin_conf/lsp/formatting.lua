local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
  return
end

formatter.setup({
  lua = {
    require("formatter.filetypes.lua").stylua,
  },
  ["*"] = {
    -- "formatter.filetypes.any" defines default configurations for any
    -- filetype
    require("formatter.filetypes.any").remove_trailing_whitespace,
  },
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  command = "FormatWrite"
})
