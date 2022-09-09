local status_ok, liteeLib = pcall(require, "litee.lib")
if not status_ok then
    return
end

liteeLib.setup({
    tree = {
        icon_set = "nerd", -- can be "codicons", "nerd"
    },
    panel = {
        orientation = "right",
        panel_size = 50,
    },
})

-- dark
vim.cmd([[highlight LTSymbol guifg=#87afd7 gui=None]])
vim.cmd(
    [[highlight LTSymbolJump ctermfg=015 ctermbg=110 cterm=italic,bold   guifg=#464646 guibg=#87afd7 gui=italic,bold]]
)
vim.cmd(
    [[highlight LTSymbolJumpRefs ctermfg=015 ctermbg=110 cterm=italic,bold   guifg=#464646 guibg=#9b885c gui=italic,bold]]
)

-- light
-- vim.cmd([[highlight LTSymbol guifg=#806CCF gui=None]])
-- vim.cmd([[highlight LTSymbolJump ctermfg=015 ctermbg=110 cterm=italic,bold   guifg=#464646 guibg=#87afd7 gui=italic,bold]])
-- vim.cmd([[highlight LTSymbolJumpRefs ctermfg=015 ctermbg=110 cterm=italic,bold   guifg=#464646 guibg=#9b885c gui=italic,bold]])

local dark = {
    LTBoolean = "hi LTBoolean                guifg=#0087af guibg=None",
    LTConstant = "hi LTConstant               guifg=#0087af guibg=None",
    LTConstructor = "hi LTConstructor            guifg=#4DC5C6 guibg=None",
    LTField = "hi LTField                  guifg=#0087af guibg=None",
    LTFunction = "hi LTFunction               guifg=#988ACF guibg=None",
    LTMethod = "hi LTMethod                 guifg=#0087af guibg=None",
    LTNamespace = "hi LTNamespace              guifg=#87af87 guibg=None",
    LTNumber = "hi LTNumber                 guifg=#9b885c guibg=None",
    LTOperator = "hi LTOperator               guifg=#988ACF guibg=None",
    LTParameter = "hi LTParameter              guifg=#988ACF guibg=None",
    LTParameterReference = "hi LTParameterReference     guifg=#4DC5C6 guibg=None",
    LTString = "hi LTString                 guifg=#af5f5f guibg=None",
    LTSymbol = "hi LTSymbol                 guifg=#87afd7 gui=underline",
    LTSymbolDetail = "hi LTSymbolDetail           ctermfg=024 cterm=italic guifg=#988ACF gui=italic",
    LTSymbolJump = "hi LTSymbolJump             ctermfg=015 ctermbg=110 cterm=italic,bold,underline   guifg=#464646 guibg=#87afd7 gui=italic,bold",
    LTSymbolJumpRefs = "hi LTSymbolJumpRefs         ctermfg=015 ctermbg=110 cterm=italic,bold,underline   guifg=#464646 guibg=#9b885c gui=italic,bold",
    LTType = "hi LTType                   guifg=#9b885c guibg=None",
    LTURI = "hi LTURI                    guifg=#988ACF guibg=None",
    LTIndentGuide = "hi LTIndentGuide            guifg=None    guibg=None",
    LTExpandedGuide = "hi LTExpandedGuide          guifg=None    guibg=None",
    LTCollapsedGuide = "hi LTCollapsedGuide         guifg=None    guibg=None",
    LTSelectFiletree = "hi LTSelectFiletree ctermbg=131  ctermfg=246 cterm=None guibg=#af5f5f guifg=#e4e4e4 gui=None",
}
