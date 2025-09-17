local utils = require("config.utils")

local set_command = vim.api.nvim_create_user_command

set_command("CloseOtherBuffers", function()
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
