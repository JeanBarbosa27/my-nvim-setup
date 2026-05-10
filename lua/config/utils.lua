local M = {}

-- region key map helpers
function M.set_key(mode, key, callback, opts)
  local keymap_opts = opts or {}
  vim.keymap.set(mode, key, callback, keymap_opts)
end

function M.set_key_with_leader(mode, key, callback, opt)
  M.set_key(mode, "<space>" .. key, callback, opt)
end

function M.set_nkey(key, callback, opt)
  M.set_key_with_leader("n", key, callback, opt)
end

function M.set_vkey(key, callback, opt)
  M.set_key_with_leader("v", key, callback, opt)
end

-- endregion key map helpers

-- region clipboard helpers
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

-- region clipboard helpers

-- region code actions
function M.show_code_actions()
  vim.lsp.buf.code_action()
end

function M.show_code_diagnostics()
  vim.diagnostic.open_float()
end

-- endregion code actions

-- region file helpers
function M.get_file_name()
  return vim.fn.expand("%:t")
end

function M.get_current_file_path()
  return vim.fn.expand("%:p")
end

function M.get_current_file_relative_path()
  return vim.fn.expand("%:.")
end

function M.source_current_file()
  vim.cmd("source %")
  print("Sourced " .. vim.fn.expand("%:."))
end

function M.execute_current_file()
  vim.cmd(".lua")
end

-- endregion file helpers

-- region directory helpers
function M.get_current_directory_path()
  return vim.fn.expand("%:p:h")
end

function M.get_current_directory_relative_path()
  return vim.fn.expand("%:.:h")
end

function M.get_project_root_path()
  return vim.fn.getcwd()
end

-- endregion directory helpers

-- region windows helpers
function M.save_and_close_all_windows()
  vim.cmd("wa")
  vim.cmd("qa")
end

function M.force_close_current_window()
  vim.cmd("q!")
end

function M.force_close_all_windows()
  vim.cmd("qa!")
end

-- endregion windows helpers

-- region buffers helpers
function M.list_buffers()
  vim.cmd("ls")
end

function M.close_current_buffer()
  vim.cmd("bd")
  print(vim.fn.expand("%:t") .. " closed!")
end

function M.save_current_buffer()
  vim.cmd("w")
  print(vim.fn.expand("%:t") .. " saved!")
end

function M.save_all_buffers()
  vim.cmd("wa")
  print("All buffers saved!")
end

function M.save_and_close_current_buffer()
  vim.cmd("w")
  vim.cmd("bd")
  print(vim.fn.expand("%:t") .. "saved and closed!")
end

function M.close_other_buffers()
  vim.cmd("CloseOtherBuffers")
end

-- endregion buffers helpers

return M
