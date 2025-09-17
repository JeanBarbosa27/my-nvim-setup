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

function M.copy_selection_to_clipboard()
  -- get selection range
  local _, ls, cs = unpack(vim.fn.getpos("'<"))
  local _, le, ce = unpack(vim.fn.getpos("'>"))

  -- get buffer lines
  local lines = vim.api.nvim_buf_get_lines(0, ls - 1, le, false)

  if #lines == 0 then return end

  -- cut by column if it's only one line
  local first_line = lines[1]
  local last_line = lines[#lines]

  if #lines == 1 then
    lines[1] = string.sub(first_line, cs, ce)
  else
    lines[1] = string.sub(first_line, cs)
    lines[#lines] = string.sub(last_line, 1, ce)
  end

  vim.fn.setreg("+", table.concat(lines, "\n"))
  print("Copied selected text to clipboard")
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
