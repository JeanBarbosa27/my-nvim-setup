local utils = require("config.utils")

local M = {}

local function code_actions(args)
  utils.set_nkey("ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "LSP Code Action" })
end

local function organize_imports(args)
  utils.set_nkey("oi", function()
  end, { buffer = args.buf, desc = "LSP Organize Imports" })
end

function M.set_nkey_mappings(args)
  code_actions(args)
  organize_imports(args)
end

return M
