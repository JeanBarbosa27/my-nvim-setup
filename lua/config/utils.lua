local M = {}

function M.set_key(mode, key, callback, opts)
  local keymap_opts = opts or {}
  vim.keymap.set(mode, "<space>" .. key, callback, keymap_opts)
end

function M.set_nkey(key, callback, opt)
  M.set_key("n", key, callback, opt)
end

function M.set_vkey(key, callback, opt)
  M.set_key("v", key, callback, opt)
end

return M
