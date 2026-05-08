local utils = require("config.utils")

local set_command = vim.api.nvim_create_user_command

set_command("CloseOtherBuffers", function()
  local current = vim.api.nvim_get_current_buf()
  local closed = 0

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current
        and vim.api.nvim_buf_is_loaded(buf)
        and vim.bo[buf].buflisted
        and not vim.bo[buf].modified
    then
      vim.api.nvim_buf_delete(buf, {})
      closed = closed + 1
    end
  end
  print(("Closed %d buffer(s)"):format(closed))
end, { desc = "Close all buffers other than current" })

set_command("CloseOtherBuffersSimple", function()
  local current_buffer_number = vim.fn.bufnr("%")
  vim.cmd("bufdo exe 'if bufnr() != " .. current_buffer_number .. " | bdelete | endif'")
end, { desc = "Close all buffers other than current" })

set_command("CopyFileName", function()
  utils.copy_to_clipboard(utils.get_file_name())
end, { desc = "Copy file name to the clipboard" })

set_command("CopyFilePath", function()
  utils.copy_to_clipboard(utils.get_file_path())
end, { desc = "Copy full file path to the clipboard" })

set_command("CopyDirectoryPath", function()
  utils.copy_to_clipboard(utils.get_current_directory_path())
end, { desc = "Copy current file directory path" })

set_command("CopyProjectRootPath", function()
  utils.copy_to_clipboard(utils.get_project_root_path())
end, { desc = "Copy project root path, basically from where editor was opened" })

set_command("CopySelection", function()
  utils.copy_selection_to_clipboard()
end, { desc = "Copy selected text to the clipboard", range = true })

set_command("PRFiles", function()
  vim.cmd("DiffviewOpen main...HEAD")
end, { desc = "A shortcut for DiffviewOpen main...HEAD, to make it easier" })

set_command("PRFilesMaster", function()
  vim.cmd("DiffviewOpen master...HEAD")
end, { desc = "A shortcut for DiffviewOpen master...HEAD, to make it easier" })
