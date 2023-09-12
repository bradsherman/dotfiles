local status_ok, wt = pcall(require, "git-worktree")
if not status_ok then
    return
end

wt.on_tree_change(function(op, meta)
    if op == wt.Operations.Switch then
        print("Switched from " .. meta.prev_path .. " to " .. meta.path)
    elseif op == wt.Operations.Create then
        print(meta)
        local origin = ""
        if meta.origin then
            origin = " and origin " .. meta.origin
        end
        print("Created worktree at " .. meta.path .. " for with branch " .. meta.branch .. origin)
        -- copy vault files
        local vault_dev_handle = io.open(".vault_pass_dev", "r")
        if vault_dev_handle then
            local contents = vault_dev_handle:read("a")
            local new_vault_dev = io.open(meta.path .. "/.vault_pass_dev", "w")
            if new_vault_dev then
                new_vault_dev:write(contents)
                new_vault_dev:close()
            end
            vault_dev_handle:close()
        else
            print("Could not find .vault_pass_dev")
            local pwd_handle = io.popen("pwd")
            if pwd_handle then
                print(pwd_handle:read())
                pwd_handle:close()
            end
        end
        local vault_clearing_dev_handle = io.open(".vault_pass_clearing_dev", "r")
        if vault_clearing_dev_handle then
            local contents = vault_clearing_dev_handle:read("a")
            local new_vault_dev = io.open(meta.path .. "/.vault_pass_clearing_dev", "w")
            if new_vault_dev then
                new_vault_dev:write(contents)
                new_vault_dev:close()
            end
            vault_clearing_dev_handle:close()
        else
            print("Could not find .vault_pass_clearing_dev")
            local pwd_handle = io.popen("pwd")
            if pwd_handle then
                print(pwd_handle:read())
                pwd_handle:close()
            end
        end
        local vault_prod_handle = io.open(".vault_pass_prod", "r")
        if vault_prod_handle then
            local contents = vault_prod_handle:read("a")
            local new_vault_prod = io.open(meta.path .. "/.vault_pass_prod", "w")
            if new_vault_prod then
                new_vault_prod:write(contents)
                new_vault_prod:close()
            end
            vault_prod_handle:close()
        end
        -- git remote set-head -a origin
        local handle = io.popen("git remote set-head -a origin")
        print("Created handle")
        if handle then
            print("Successfully set local origin remote default branch")
            handle:close()
        else
            print("ERROR setting remote head")
        end
    elseif op == wt.Operations.Delete then
        print("Deleted worktree at " .. meta.path)
    end
end)

wt.setup({
    change_directory_command = "cd",
    update_on_change = true,
    update_on_change_command = "Neogit",
    clearjumps_on_change = true,
    autopush = false,
})
