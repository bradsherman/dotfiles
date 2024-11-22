return {
    "rebelot/heirline.nvim",
    enabled = true,
    config = function()
        local heirline = require("heirline")
        local conditions = require("heirline.conditions")
        local utils = require("heirline.utils")
        local function get_hl(hlgroup)
            local hl = utils.get_highlight(hlgroup)
            return setmetatable(hl, {
                __index = function()
                    return "none"
                end,
            })
        end

        local function setup_colors()
            return {
                -- bright_bg = "none",
                -- bright_fg = "none",
                bright_bg = get_hl("Folded").bg,
                bright_fg = get_hl("Folded").fg,
                red = get_hl("DiagnosticError").fg,
                dark_red = get_hl("DiffDelete").bg,
                green = get_hl("String").fg,
                blue = get_hl("Function").fg,
                gray = get_hl("NonText").fg,
                orange = get_hl("Constant").fg,
                purple = get_hl("Statement").fg,
                cyan = get_hl("Special").fg,
                diag_warn = get_hl("DiagnosticWarn").fg,
                diag_error = get_hl("DiagnosticError").fg,
                diag_hint = get_hl("DiagnosticHint").fg,
                diag_info = get_hl("DiagnosticInfo").fg,
                git_del = get_hl("DiffDeleted").fg,
                git_add = get_hl("DiffAdded").fg,
                git_change = get_hl("DiffChanged").fg,
            }
        end
        vim.api.nvim_create_augroup("Heirline", { clear = true })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                utils.on_colorscheme(setup_colors)
            end,
            group = "Heirline",
        })

        -- local colors = {
        --     bright_bg = kana_colors.theme.ui.bg_p1,
        --     bright_fg = kana_colors.theme.ui.fg,
        --     red = kana_colors.theme.diag.error,
        --     dark_red = kana_colors.theme.diff.delete,
        --     green = kana_colors.theme.syn.string,
        --     blue = kana_colors.theme.syn.fun,
        --     gray = kana_colors.theme.ui.nontext,
        --     orange = kana_colors.theme.syn.constant,
        --     purple = kana_colors.theme.syn.statement,
        --     cyan = kana_colors.theme.ui.special,
        --     diag_warn = kana_colors.theme.diag.warning,
        --     diag_error = kana_colors.theme.diag.error,
        --     diag_hint = kana_colors.theme.diag.hint,
        --     diag_info = kana_colors.theme.diag.info,
        --     git_del = kana_colors.theme.diff.delete,
        --     git_add = kana_colors.theme.diff.add,
        --     git_change = kana_colors.theme.diff.change,
        -- }
        heirline.load_colors(setup_colors)

        local ViMode = {
            -- get vim current mode, this information will be required by the provider
            -- and the highlight functions, so we compute it only once per component
            -- evaluation and store it as a component attribute
            init = function(self)
                self.mode = vim.fn.mode(1) -- :h mode()
            end,
            -- Now we define some dictionaries to map the output of mode() to the
            -- corresponding string and color. We can put these into `static` to compute
            -- them at initialisation time.
            static = {
                mode_names = { -- change the strings if you like it vvvvverbose!
                    n = "N",
                    no = "N?",
                    nov = "N?",
                    noV = "N?",
                    ["no\22"] = "N?",
                    niI = "Ni",
                    niR = "Nr",
                    niV = "Nv",
                    nt = "Nt",
                    v = "V",
                    vs = "Vs",
                    V = "V_",
                    Vs = "Vs",
                    ["\22"] = "^V",
                    ["\22s"] = "^V",
                    s = "S",
                    S = "S_",
                    ["\19"] = "^S",
                    i = "I",
                    ic = "Ic",
                    ix = "Ix",
                    R = "R",
                    Rc = "Rc",
                    Rx = "Rx",
                    Rv = "Rv",
                    Rvc = "Rv",
                    Rvx = "Rv",
                    c = "C",
                    cv = "Ex",
                    r = "...",
                    rm = "M",
                    ["r?"] = "?",
                    ["!"] = "!",
                    t = "T",
                },
                mode_colors = {
                    n = "#FF5D62",
                    i = "#98BB6C",
                    v = "#658594",
                    V = "#658594",
                    ["\22"] = "#658594",
                    c = "#FF9E3B",
                    s = "#957FB8",
                    S = "#957FB8",
                    ["\19"] = "#957FB8",
                    R = "#FF9E3B",
                    r = "#FF9E3B",
                    ["!"] = "#FF5D62",
                    t = "#FF5D62",
                },
            },
            -- We can now access the value of mode() that, by now, would have been
            -- computed by `init()` and use it to index our strings dictionary.
            -- note how `static` fields become just regular attributes once the
            -- component is instantiated.
            -- To be extra meticulous, we can also add some vim statusline syntax to
            -- control the padding and make sure our string is always at least 2
            -- characters long. Plus a nice Icon.
            provider = function(self)
                return " %2(" .. self.mode_names[self.mode] .. "%)"
            end,
            -- Same goes for the highlight. Now the foreground will change according to the current mode.
            hl = function(self)
                local mode = self.mode:sub(1, 1) -- get only the first mode character
                return { fg = self.mode_colors[mode], bold = true }
            end,
            -- Re-evaluate the component only on ModeChanged event!
            -- Also allows the statusline to be re-evaluated when entering operator-pending mode
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            },
        }

        local FileNameBlock = {
            -- let's first set up some attributes needed by this component and it's children
            init = function(self)
                self.filename = vim.api.nvim_buf_get_name(0)
            end,
        }
        -- We can now define some children separately and add them later

        local FileIcon = {
            init = function(self)
                local filename = self.filename
                local extension = vim.fn.fnamemodify(filename, ":e")
                self.icon, self.icon_color =
                    require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
            end,
            provider = function(self)
                return self.icon and (self.icon .. " ")
            end,
            hl = function(self)
                return { fg = self.icon_color }
            end,
        }

        local FileName = {
            provider = function(self)
                -- first, trim the pattern relative to the current directory. For other
                -- options, see :h filename-modifers
                local filename = vim.fn.fnamemodify(self.filename, ":t")
                if filename == "" then
                    return "[No Name]"
                end
                -- now, if the filename would occupy more than 1/4th of the available
                -- space, we trim the file path to its initials
                -- See Flexible Components section below for dynamic truncation
                -- if not conditions.width_percent_below(#filename, 0.25) then
                --     filename = vim.fn.pathshorten(filename)
                -- end
                return filename
            end,
            hl = { fg = utils.get_highlight("Directory").fg },
        }

        local FileFlags = {
            {
                condition = function()
                    return vim.bo.modified
                end,
                provider = "[+]",
                hl = { fg = "green" },
            },
            {
                condition = function()
                    return not vim.bo.modifiable or vim.bo.readonly
                end,
                provider = "  ",
                hl = { fg = "orange" },
            },
        }

        -- Now, let's say that we want the filename color to change if the buffer is
        -- modified. Of course, we could do that directly using the FileName.hl field,
        -- but we'll see how easy it is to alter existing components using a "modifier"
        -- component

        local FileNameModifer = {
            hl = function()
                if vim.bo.modified then
                    -- use `force` because we need to override the child's hl foreground
                    return { fg = "cyan", bold = true, force = true }
                end
            end,
        }

        -- let's add the children to our FileNameBlock component
        FileNameBlock = utils.insert(
            FileNameBlock,
            FileIcon,
            utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
            FileFlags,
            { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
        )

        local FileType = {
            provider = function()
                return string.upper(vim.bo.filetype)
            end,
            hl = { fg = utils.get_highlight("Type").fg, bold = true },
        }

        local FileEncoding = {
            provider = function()
                local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
                return enc ~= "utf-8" and enc:upper()
            end,
        }

        local FileFormat = {
            provider = function()
                local fmt = vim.bo.fileformat
                return fmt ~= "unix" and fmt:upper()
            end,
        }

        local FileSize = {
            provider = function()
                -- stackoverflow, compute human readable file size
                local suffix = { "b", "k", "M", "G", "T", "P", "E" }
                local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
                fsize = (fsize < 0 and 0) or fsize
                if fsize < 1024 then
                    return fsize .. suffix[1]
                end
                local i = math.floor((math.log(fsize) / math.log(1024)))
                return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
            end,
        }

        local FileLastModified = {
            -- did you know? Vim is full of functions!
            provider = function()
                local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
                return (ftime > 0) and os.date("%c", ftime)
            end,
        }

        -- We're getting minimalists here!
        local Ruler = {
            -- %l = current line number
            -- %L = number of lines in the buffer
            -- %c = column number
            -- %P = percentage through file of displayed window
            provider = "%7(%l/%3L%):%2c %P",
        }

        local SearchCount = {
            condition = function()
                return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
            end,
            init = function(self)
                local ok, search = pcall(vim.fn.searchcount)
                if ok and search.total then
                    self.search = search
                end
            end,
            provider = function(self)
                local search = self.search
                return string.format(" %d/%d", search.current, math.min(search.total, search.maxcount))
            end,
            hl = { fg = "purple", bold = true },
        }

        -- I take no credits for this! :lion:
        local ScrollBar = {
            static = {
                sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
                -- Another variant, because the more choice the better.
                -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
            },
            provider = function(self)
                local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                local lines = vim.api.nvim_buf_line_count(0)
                local i
                if lines > 0 then
                    i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                else
                    i = #self.sbar
                end
                return string.rep(self.sbar[i], 2)
            end,
            hl = { fg = "blue", bg = "bright_bg" },
        }

        local lsp_attached = function()
            return next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil
        end

        local LSPActive = {
            condition = lsp_attached,
            update = { "LspAttach", "LspDetach" },

            -- You can keep it simple,
            -- provider = " [LSP]",

            -- Or complicate things a bit and get the servers names
            provider = function()
                local names = {}
                for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    table.insert(names, server.name)
                end
                return " [" .. table.concat(names, ", ") .. "]"
            end,
            hl = { fg = "green", bold = true },
        }

        local Diagnostics = {

            condition = conditions.has_diagnostics,

            -- { name = "DiagnosticSignError", text = " " },
            -- { name = "DiagnosticSignWarn", text = " " },
            -- { name = "DiagnosticSignHint", text = " " },
            -- { name = "DiagnosticSignInfo", text = " " },
            static = {
                error_icon = " ",
                warn_icon = " ",
                info_icon = " ",
                hint_icon = " ",
            },

            init = function(self)
                -- vim.print(vim.fn.sign_getdefined("DiagnosticSignWarn"))
                self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            end,

            update = { "DiagnosticChanged", "BufEnter" },

            {
                provider = "![",
            },
            {
                provider = function(self)
                    -- 0 is just another output, we can decide to print it or not!
                    return self.errors > 0 and (self.error_icon .. self.errors .. " ")
                end,
                hl = { fg = "diag_error" },
            },
            {
                provider = function(self)
                    return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
                end,
                hl = { fg = "diag_warn" },
            },
            {
                provider = function(self)
                    return self.info > 0 and (self.info_icon .. self.info .. " ")
                end,
                hl = { fg = "diag_info" },
            },
            {
                provider = function(self)
                    return self.hints > 0 and (self.hint_icon .. self.hints)
                end,
                hl = { fg = "diag_hint" },
            },
            {
                provider = "]",
            },
        }

        local Git = {
            condition = conditions.is_git_repo,

            init = function(self)
                self.status_dict = vim.b.gitsigns_status_dict
                self.has_changes = self.status_dict.added ~= 0
                    or self.status_dict.removed ~= 0
                    or self.status_dict.changed ~= 0
            end,

            hl = { fg = "orange" },

            { -- git branch name
                provider = function(self)
                    return " " .. self.status_dict.head
                end,
                hl = { bold = true },
            },
            -- You could handle delimiters, icons and counts similar to Diagnostics
            {
                condition = function(self)
                    return self.has_changes
                end,
                provider = "(",
            },
            {
                provider = function(self)
                    local count = self.status_dict.added or 0
                    return count > 0 and ("+" .. count)
                end,
                hl = { fg = "git_add" },
            },
            {
                provider = function(self)
                    local count = self.status_dict.removed or 0
                    return count > 0 and ("-" .. count)
                end,
                hl = { fg = "git_del" },
            },
            {
                provider = function(self)
                    local count = self.status_dict.changed or 0
                    return count > 0 and ("~" .. count)
                end,
                hl = { fg = "git_change" },
            },
            {
                condition = function(self)
                    return self.has_changes
                end,
                provider = ")",
            },
        }

        local DAPMessages = {
            condition = function()
                local session = require("dap").session()
                return session ~= nil
            end,
            provider = function()
                return " " .. require("dap").status()
            end,
            hl = "Debug",
            -- see Click-it! section for clickable actions
        }

        local WorkDir = {
            provider = function()
                local icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
                local cwd = vim.fn.getcwd(0)
                cwd = vim.fn.fnamemodify(cwd, ":~")
                if not conditions.width_percent_below(#cwd, 0.25) then
                    cwd = vim.fn.pathshorten(cwd)
                end
                local trail = cwd:sub(-1) == "/" and "" or "/"
                return icon .. cwd .. trail
            end,
            hl = { fg = "blue", bold = true },
        }

        local Spacer = { provider = " " }
        local function rpad(child)
            return {
                condition = child.condition,
                child,
                Spacer,
            }
        end
        local function OverseerTasksForStatus(status)
            return {
                condition = function(self)
                    return self.tasks[status]
                end,
                provider = function(self)
                    return string.format("%s%d", self.symbols[status], #self.tasks[status])
                end,
                hl = function(self)
                    return {
                        fg = utils.get_highlight(string.format("Overseer%s", status)).fg,
                    }
                end,
            }
        end

        local Overseer = {
            condition = function()
                return package.loaded.overseer
            end,
            init = function(self)
                local tasks = require("overseer.task_list").list_tasks({ unique = true })
                local tasks_by_status = require("overseer.util").tbl_group_by(tasks, "status")
                self.tasks = tasks_by_status
            end,
            static = {
                symbols = {
                    ["CANCELED"] = " ",
                    ["FAILURE"] = "󰅚 ",
                    ["SUCCESS"] = "󰄴 ",
                    ["RUNNING"] = "󰑮 ",
                },
            },

            rpad(OverseerTasksForStatus("CANCELED")),
            rpad(OverseerTasksForStatus("RUNNING")),
            rpad(OverseerTasksForStatus("SUCCESS")),
            rpad(OverseerTasksForStatus("FAILURE")),
        }

        local Align = { provider = "%=" }
        local Space = { provider = " " }

        local StatusLine = {
            ViMode,
            Space,
            -- WorkDir,
            FileNameBlock,
            { provider = "%<" },
            Space,
            Git,
            Space,
            Diagnostics,
            Space,
            Overseer,
            Align,
            -- { flexible = 3,   { Navic, Space }, { provider = "" } },
            LSPActive,
            Align,
            DAPMessages,
            -- VirtualEnv,
            Space,
            FileType,
            { flexible = 3, { FileEncoding, Space }, { provider = "" } },
            Space,
            Ruler,
            SearchCount,
            Space,
            ScrollBar,
        }

        heirline.setup({
            statusline = StatusLine,
            -- winbar = { ... },
            -- tabline = { ... },
            -- statuscolumn = { ... },
            opts = {
                colors = setup_colors(),
            },
        })
    end,
}
