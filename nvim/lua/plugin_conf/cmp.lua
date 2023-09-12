local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local luasnip_status_ok, luasnip_snippets = pcall(require, "luasnip-snippets")
if luasnip_status_ok then
    luasnip.snippets = luasnip_snippets.load_snippets()
end
luasnip.config.setup({ history = false })

local hask_snips_ok, haskell_snippets = pcall(require, "haskell-snippets")
if hask_snips_ok then
    luasnip.add_snippets("haskell", haskell_snippets.all, { key = "haskell" })
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local window_ops = cmp.config.window.bordered()
window_ops.border = "rounded" -- default

local nfox_ok, palettes = pcall(require, "nightfox.palette")
local palette = palettes.load("nordfox")

if false and nfox_ok then
    local cmp_highlights = {
        PmenuSel = { bg = palette.bg1, fg = "NONE" },
        Pmenu = { fg = palette.fg0, bg = palette.bg1 },

        CmpItemKindField = { fg = palette.fg1, bg = palette.red.base },
        CmpItemKindProperty = { fg = palette.fg1, bg = palette.red.base },
        CmpItemKindEvent = { fg = palette.fg1, bg = palette.red.base },

        CmpItemKindText = { fg = palette.fg1, bg = palette.green.dim },
        CmpItemKindEnum = { fg = palette.fg1, bg = palette.green.dim },
        CmpItemKindKeyword = { fg = palette.fg1, bg = palette.green.dim },

        CmpItemKindConstant = { fg = palette.fg1, bg = palette.yellow.base },
        CmpItemKindConstructor = { fg = palette.fg1, bg = palette.yellow.base },
        CmpItemKindReference = { fg = palette.fg1, bg = palette.yellow.base },

        CmpItemKindFunction = { fg = palette.fg1, bg = palette.magenta.base },
        CmpItemKindStruct = { fg = palette.fg1, bg = palette.magenta.base },
        CmpItemKindClass = { fg = palette.fg1, bg = palette.magenta.base },
        CmpItemKindModule = { fg = palette.fg1, bg = palette.magenta.base },
        CmpItemKindOperator = { fg = palette.fg1, bg = palette.magenta.base },

        CmpItemKindVariable = { fg = palette.white.bright, bg = palette.black.base },
        CmpItemKindFile = { fg = palette.white.bright, bg = palette.black.base },

        CmpItemKindUnit = { fg = palette.fg1, bg = palette.orange.base },
        CmpItemKindSnippet = { fg = palette.fg1, bg = palette.orange.base },
        CmpItemKindFolder = { fg = palette.fg1, bg = palette.orange.base },

        CmpItemKindMethod = { fg = palette.fg1, bg = palette.blue.base },
        CmpItemKindValue = { fg = palette.fg1, bg = palette.blue.base },
        CmpItemKindEnumMember = { fg = palette.fg1, bg = palette.blue.base },

        CmpItemKindInterface = { fg = palette.fg1, bg = palette.cyan.base },
        CmpItemKindColor = { fg = palette.fg1, bg = palette.cyan.base },
        CmpItemKindTypeParameter = { fg = palette.fg1, bg = palette.cyan.base },
    }

    local cmp_with_fmt = {
        CmpItemAbbrDeprecated = { fg = palette.fg2, bg = "NONE", fmt = "strikethrough" },
        CmpItemAbbrMatch = { fg = palette.blue.bright, bg = "NONE", fmt = "bold" },
        CmpItemAbbrMatchFuzzy = { fg = palette.blue.bright, bg = "NONE", fmt = "bold" },
        CmpItemMenu = { fg = palette.pink.dim, bg = "NONE", fmt = "italic" },
    }

    for name, hl in pairs(cmp_highlights) do
        vim.cmd("highlight " .. name .. " guifg=" .. hl.fg .. " guibg=" .. hl.bg)
    end

    for name, hl in pairs(cmp_with_fmt) do
        vim.cmd("highlight " .. name .. " guifg=" .. hl.fg .. " guibg=" .. hl.bg .. " gui=" .. hl.fmt)
    end
end

local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = window_ops,
        -- completion = {
        --     winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        --     col_offset = -3,
        --     side_padding = 0,
        -- },
        documentation = window_ops,
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
                local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                if icon then
                    vim_item.kind = icon
                    vim_item.kind_hl_group = hl_group
                    return vim_item
                end
            end

            -- Kind icons
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item({ "i", "c" }),
        ["<C-n>"] = cmp.mapping.select_next_item({ "i", "c" }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "treesitter" },
        -- { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "neorg" },
        { name = "tags" },
    }),
    experimental = {
        ghost_text = false,
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "buffer" },
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
        { name = "buffer" },
    }),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- this loads friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()
