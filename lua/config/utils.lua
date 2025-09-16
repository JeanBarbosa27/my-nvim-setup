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

function M.copy_to_clipboard(object_to_copy)
  vim.fn.setreg("+", object_to_copy)
  print(string.format("Copied %s to the clipboard", object_to_copy))
end

function M.get_file_name()
  return vim.fn.expand("%:t")
end

function M.get_file_path()
  return vim.api.nvim_buf_get_name(0)
end

function M.get_current_directory_path()
  local file_name = M.get_file_name()
  local full_path = M.get_file_path()
  return full_path:gsub(file_name, "")
end

function M.get_project_root_path()
  return vim.fn.system("pwd"):gsub("\n", "")
end

return M
