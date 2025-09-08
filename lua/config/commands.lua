-- Close all other buffers
vim.api.nvim_create_user_command("BOnly", function()
  local current_buffer_number = vim.fn.bufnr("%")
  vim.cmd("bufdo exe 'if bufnr() != " .. current_buffer_number .. " | bdelete | endif'")
end, { desc = "Close all buffers other than current" })
