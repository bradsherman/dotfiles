-- make sure dap is installed before doing any keybindings
local status_ok, dap = pcall(require, "dap")
if not status_ok then
    return
end

local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
    return
end

require("plugin_conf.dbg.adapters")
require("plugin_conf.dbg.dap_ui")
require("plugin_conf.dbg.virtual_text")

vim.keymap.set("n", "<F4>", ":lua require('dapui').toggle()<CR>")
vim.keymap.set("n", "<F5>", ":lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set("n", "<F9>", ":lua require('dap').continue()<CR>")

vim.keymap.set("n", "<F1>", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<F2>", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<F3>", ":lua require('dap').step_out()<CR>")

vim.keymap.set("n", "<Leader>dsc", ":lua require('dap').continue()<CR>")
vim.keymap.set("n", "<Leader>dsv", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<Leader>dsi", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<Leader>dso", ":lua require('dap').step_out()<CR>")

vim.keymap.set("n", "<Leader>dhh", ":lua require('dap.ui.variables').hover()<CR>")
vim.keymap.set("v", "<Leader>dhv", ":lua require('dap.ui.variables').visual_hover()<CR>")

vim.keymap.set("n", "<Leader>duh", ":lua require('dap.ui.widgets').hover()<CR>")
vim.keymap.set(
    "n",
    "<Leader>duf",
    ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>"
)

vim.keymap.set("n", "<Leader>dro", ":lua require('dap').repl.open()<CR>")
vim.keymap.set("n", "<Leader>drl", ":lua require('dap').repl.run_last()<CR>")

vim.keymap.set("n", "<Leader>dbc", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set(
    "n",
    "<Leader>dbm",
    ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>"
)
vim.keymap.set("n", "<Leader>dbt", ":lua require('dap').toggle_breakpoint()<CR>")

vim.keymap.set("n", "<Leader>dc", ":lua require('dap.ui.variables').scopes()<CR>")
vim.keymap.set("n", "<Leader>di", ":lua require('dapui').toggle()<CR>")

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
--
-- DAP integration
-- Make sure to also have the snippet with the common helper functions in your config!
-- Utility functions shared between progress reports for LSP and DAP

local client_notifs = {}

local function get_notif_data(client_id, token)
    if not client_notifs[client_id] then
        client_notifs[client_id] = {}
    end

    if not client_notifs[client_id][token] then
        client_notifs[client_id][token] = {}
    end

    return client_notifs[client_id][token]
end

local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function update_spinner(client_id, token)
    local notif_data = get_notif_data(client_id, token)

    if notif_data.spinner then
        local new_spinner = (notif_data.spinner + 1) % #spinner_frames
        notif_data.spinner = new_spinner

        notif_data.notification = vim.notify(nil, nil, {
            hide_from_history = true,
            icon = spinner_frames[new_spinner],
            replace = notif_data.notification,
        })

        vim.defer_fn(function()
            update_spinner(client_id, token)
        end, 100)
    end
end

local function format_title(title, client_name)
    return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
    return (percentage and percentage .. "%\t" or "") .. (message or "")
end

dap.listeners.before["event_progressStart"]["progress-notifications"] = function(session, body)
    local notif_data = get_notif_data("dap", body.progressId)

    local message = format_message(body.message, body.percentage)
    notif_data.notification = vim.notify(message, "info", {
        title = format_title(body.title, session.config.type),
        icon = spinner_frames[1],
        timeout = false,
        hide_from_history = false,
    })

    notif_data.notification.spinner = 1, update_spinner("dap", body.progressId)
end

dap.listeners.before["event_progressUpdate"]["progress-notifications"] = function(session, body)
    local notif_data = get_notif_data("dap", body.progressId)
    notif_data.notification = vim.notify(format_message(body.message, body.percentage), "info", {
        replace = notif_data.notification,
        hide_from_history = false,
    })
end

dap.listeners.before["event_progressEnd"]["progress-notifications"] = function(session, body)
    local notif_data = client_notifs["dap"][body.progressId]
    notif_data.notification = vim.notify(body.message and format_message(body.message) or "Complete", "info", {
        icon = "",
        replace = notif_data.notification,
        timeout = 3000,
    })
    notif_data.spinner = nil
end
