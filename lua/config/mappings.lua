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

-- <QUICK FIX LIST>
utils.set_key("n", "<M-q>", "lua vim.diagnostic.setqflist()") -- search for quick fixes
utils.set_key("n", "<M-o>", "<cmd>copen<CR>")                 -- opens quick fix list
utils.set_key("n", "<M-c>", "<cmd>cclose<CR>")                -- closes quick fix list
-- navigate through quick fix items
utils.set_key("n", "<M-k>", "<cmd>cprev<CR>")
utils.set_key("n", "<M-j>", "<cmd>cnext<CR>")
-- </QUICK FIX LIST>

-- <TERMINAL>
local job_id = 0
utils.set_nkey("st", function()
  -- This opens a terminal on the right. Once this is opened, type "<C-\><C-n>" to go to normal mode
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("L")
  -- FIXME: Find a way to get this as percentage, since on small screens this breaks the view
  vim.api.nvim_win_set_width(0, 110)

  job_id = vim.bo.channel
end)

utils.set_nkey("ex", function()
  -- This is only an example on how we can use the terminal into nvim, but imagine running commands like unit tests,
  -- builds, deploy, etc
  vim.fn.chansend(job_id, { "ls -al \r\n" })
end)
-- </TERMINAL>

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
utils.set_vkey("y", ":CopySelection<CR>")
