local set = vim.keymap.set

-- NORMAL MODE MAPPINGS

-- source current file
set("n", "<space><space>r", "<cmd>source %<CR>")
-- execute current file
set("n", "<space>r", ":.lua<CR>")

-- close current buffer
set("n", "<space>x", ":bd<CR>")

-- save current buffer
set("n", "<space>w", ":w<CR>")

-- save and close current buffer
set("n", "<space>X", ":w<CR>:bd<CR>")
-- close all other buffers
set("n", "<space>bo", "<cmd>BOnly<CR>", { desc = "Close all other buffers" })

-- copy file name to the clipboard
set("n", "<space>cf", function()
  local file_name = vim.fn.expand("%:t")
  vim.fn.setreg("+", file_name)
  print(string.format("Copied %s to clipboard!", file_name))
end)

-- copy full file path to the clipboard
set("n", "<space>cp", function()
  local full_path = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg("+", full_path)
  print(string.format("Copied %s to clipboard!", full_path))
end)

-- VISUAL MODE MAPPINGS
set("v", "<space>r", ":lua<CR>")
