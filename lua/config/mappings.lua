local utils = require("config.utils")

-- NORMAL MODE MAPPINGS

-- <BUFFERS>
-- list buffers
utils.set_nkey("bl", ":ls<CR>")

-- close current buffer
utils.set_nkey("bx", ":bd<CR>")

-- save current buffer
utils.set_nkey("bw", ":w<CR>")

-- save all buffers
utils.set_nkey("bW", ":wa<CR>")

-- save and close current buffer
utils.set_nkey("bX", ":w<CR>:bd<CR>")

-- close all other buffers
utils.set_nkey("bo", "<cmd>BOnly<CR>", { desc = "Close all other buffers" })
-- </BUFFERS>

-- <FILE>
-- source current file
utils.set_nkey("<space>r", "<cmd>source %<CR>")

-- execute current file
utils.set_nkey("r", ":.lua<CR>")

-- copy file name to the clipboard
utils.set_nkey("cf", function()
  local file_name = vim.fn.expand("%:t")
  vim.fn.setreg("+", file_name)
  print(string.format("Copied %s to clipboard!", file_name))
end)

-- copy full file path to the clipboard
utils.set_nkey("cp", function()
  local full_path = vim.api.nvim_buf_get_name(0)
  vim.fn.setreg("+", full_path)
  print(string.format("Copied %s to clipboard!", full_path))
end)
-- </FILE>

-- VISUAL MODE MAPPINGS
-- Execute selected lua code
utils.set_vkey("r", ":lua<CR>")

-- copy selection
utils.set_vkey("y", ":CopySelection")
