local M = {}

M.reload = function()
    for name, _ in pairs(package.loaded) do
        if name:match("^user") and name ~= "user.plugins.lsp.mason" and name ~= "user.plugins.autopairs" then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    vim.cmd("PackerCompile")
end

M.print = function(v)
    print(vim.inspect(v))
    return v
end

--[[ if pcall(require, "plenary") then ]]
--[[     RELOAD = require("plenary.reload").reload_module ]]
--[[]]
--[[     M.reload = function(name) ]]
--[[         RELOAD(name) ]]
--[[         return require(name) ]]
--[[     end ]]
--[[ end ]]

M.file_exists = function(name)
    local handle = io.popen("which " .. name)
    if not handle then
        return
    end
    local full_path = handle:read("l")
    handle:close()

    local f = io.open(full_path, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

M.update_haskell_tags = function()
    local succ, exitcode, code = os.execute("ghc-tags -c")
    if not succ then
        vim.notify("Failed to update tags - exitcode = (" .. exitcode .. "), code (" .. code .. ")")
    end
    vim.notify("Tags updated successfully")
end

return M
