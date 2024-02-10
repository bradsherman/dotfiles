local M = {}

M.reload = function()
    for name, _ in pairs(package.loaded) do
        if name:match("^user") and name ~= "user.plugins.lsp.mason" and name ~= "user.plugins.autopairs" then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    vim.cmd("Lazy sync")
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
    os.execute("rm tags")
    local succ, exitcode, code = os.execute("ghc-tags -c")
    if succ then
        vim.notify("Tags updated successfully")
    else
        vim.notify("Failed to update tags - exitcode = (" .. exitcode .. "), code (" .. code .. ")")
    end
end

M.worktree_workaround = function()
    vim.ui.input({
        prompt = "Choose branch name",
    }, function(branch)
        if branch ~= nil then
            require("git-worktree").create_worktree("../" .. branch, branch, "origin")
            --[[ os.execute("git pull --rebase origin master") ]]
        else
            print("Branch is nil")
        end
    end)
end
-- see if the file exists
local function file_exists(file)
    local f = io.open(file, "rb")
    if f then
        f:close()
    end
    return f ~= nil
end

M.get_haskell_package_name = function()
    local HtProjectHelpers = require("haskell-tools.project.helpers")
    local file = vim.api.nvim_buf_get_name(0)
    local result = HtProjectHelpers.get_package_yaml(file)

    if not file_exists(result) then
        vim.notify("Unable to find package.yaml")
    end

    local package_name = nil
    for line in io.lines(result) do
        for k, v in string.gmatch(line, "(%a+):%s+(.+)") do
            if k == "name" then
                package_name = v
            end
        end
    end
    if not package_name then
        vim.notify("Unable to find package name.")
    else
        return package_name
        -- local Terminal = require("toggleterm.terminal").Terminal
        -- local stack = Terminal:new({ cmd = "stack build " .. package_name })
        -- -- TODO: figure out how to report result, use overseer?
        -- stack:toggle()
    end
end

return M
