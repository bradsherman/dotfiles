local map = require 'utils'.map
local nvim_lsp = require('lspconfig')
local lsp_status = require('lsp-status')

lsp_status.register_progress()
local kind_labels_mt = {__index = function(_, k) return k end}
local kind_labels = {}
setmetatable(kind_labels, kind_labels_mt)
lsp_status.config({
  kind_labels = kind_labels,
  indicator_errors = "×",
  indicator_warnings = "!",
  indicator_info = "i",
  indicator_hint = "›",
})
require'lsp_signature'.on_attach()

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>ce', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader>cf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
  lsp_status.on_attach(client, bufnr)

  if client.resolved_capabilities.document_formatting then
          vim.api.nvim_exec([[
          augroup LspAutocommands
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 5000)
          augroup END
          ]], true)
      end
end

-- loop over default servers
local servers_default = {
  "rust_analyzer",
  "bashls",
  "dockerls",
  "graphql",
  "dhall_lsp_server",
  "jsonls",
  "julials",
  -- need to do special setup
  --"sqlls",
  "terraformls",
  "vimls"
}
lsp_status.capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_status.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
for _, lsp in ipairs(servers_default) do
  nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = lsp_status.capabilities }
end

-- special setup for haskell & lua
nvim_lsp.hls.setup{
    settings = {
      languageServerHaskell = {
        formattingProvider = "fourmolu"
      }
    },
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

nvim_lsp.sumneko_lua.setup {
  cmd = {"/home/bsherman/code/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/bsherman/code/lua-language-server/main.lua"},
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        globals = {'vim'}
      }
    }
  },
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}

nvim_lsp.tsserver.setup {
  on_attach = function(client)
    -- disable formatting to prevent issues with prettier
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end,
  capabilities = lsp_status.capabilities
}

local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
}
local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        securities = {[2] = "error", [1] = "warning"}
    }
}

local formatters = {
    prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
}
local formatFiletypes = {
    typescript = "prettier",
    typescriptreact = "prettier"
}

nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}



local function preview_location_callback(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    vim.lsp.log.info(method, 'No location found')
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end


map('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', {silent = true, noremap = true})
map('n', 'gr', '<cmd>Telescope lsp_references<cr>', {silent = true, noremap = true})
map('n', '<c-m>', '<cmd>Telescope lsp_document_symbols<cr>', {silent = true, noremap = true})
map('n', 'gi', '<cmd>Telescope vim.lsp.buf.implementation()<cr>', {silent = true, noremap = true})
map('n', 'gD', '<cmd>lua PeekDefinition()<cr>', {silent = true, noremap = true})
map('n', '<leader>lt', '<cmd>:LspTroubleToggle<cr>', {silent = true, noremap = true})
map('n', '<leader>ltr', '<cmd>:LspTroubleRefresh<cr>', {silent = true, noremap = true})
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {silent = true, noremap = true})
map('n', '<c-x>', '<cmd>lua vim.lsp.diagnostic.set_loclist({open_loclist = true})<cr>', {silent = true, noremap = true})
map('n', '<c-p>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', {silent = true, noremap = true})
map('n', '<c-n>', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', {silent = true, noremap = true})
