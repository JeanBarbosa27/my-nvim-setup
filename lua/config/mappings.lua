local utils = require("config.utils")

-- region normal mode
-- region buffers
utils.set_nkey("bl", utils.list_buffers, { desc = "List buffers" })
utils.set_nkey("bX", utils.close_current_buffer, { desc = "Close current buffer" })
utils.set_nkey("bW", utils.save_current_buffer, { desc = "Save current buffer" })
utils.set_nkey("bw", utils.save_all_buffers, { desc = "Save all buffers" })
utils.set_nkey("bx", utils.save_and_close_current_buffer, { desc = "Save and close current buffer" })
utils.set_nkey("bo", utils.close_other_buffers, { desc = "Close all other buffers" })
-- endregion buffers

-- region windows
utils.set_nkey("X", utils.save_and_close_all_windows, { desc = "Save and close all windows" })
utils.set_nkey("q", utils.force_close_current_window, { desc = "Force close current windows" })
utils.set_nkey("Q", utils.force_close_all_windows, { desc = "Force close all windows" })
-- endregion windows

-- region code actions
utils.set_nkey("cd", utils.show_code_diagnostics, { desc = "Show code diagnostic on the status line" })
-- endregion code actions

-- region quickfix list
utils.set_key("n", "<M-q>", "lua vim.diagnostic.setqflist()") -- search for quick fixes
utils.set_key("n", "<M-o>", "<cmd>copen<CR>")                 -- opens quick fix list
utils.set_key("n", "<M-c>", "<cmd>cclose<CR>")                -- closes quick fix list
-- navigate through quick fix items
utils.set_key("n", "<M-k>", "<cmd>cprev<CR>")
utils.set_key("n", "<M-j>", "<cmd>cnext<CR>")
-- endregion quickfix list

-- region terminal
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

utils.set_nkey("tt", function()
  vim.cmd("tabnew")
  vim.cmd.term()
end, { desc = "Open a new terminal on another tab" })

utils.set_tkey("<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit back to normal mode on terminal" })

utils.set_nkey("ex", function()
  -- This is only an example on how we can use the terminal into nvim, but imagine running commands like unit tests,
  -- builds, deploy, etc
  vim.fn.chansend(job_id, { "ls -al \r\n" })
end)
-- endregion terminal

-- region files
utils.set_nkey("<space>r", utils.source_current_file, { desc = "Source current file" })
utils.set_nkey("r", utils.execute_current_file, { desc = "Execute current file" })
utils.set_nkey("cfn", "<cmd>CopyFileName<CR>", { desc = "Copy current file name to clipboard" })
utils.set_nkey("cfp", "<cmd>CopyFilePath<CR>", { desc = "Copy current file full path to clipboard" })
utils.set_nkey("cfr", "<cmd>CopyRelativeFilePath<CR>", { desc = "Copy current file relative path to clipboard" })
utils.set_nkey("crp", "<cmd>CopyProjectRootPath<CR>", { desc = "Copy project root path to clipboard" })
utils.set_nkey("cdp", "<cmd>CopyDirectoryPath<CR>", { desc = "Copy current directory full path to clipboard" })
utils.set_nkey("cdr", "<cmd>CopyRelativeDirecoryPath<CR>", { desc = "Copy current directory relative path to clipboard" })
-- endregion files
-- endregion normal mode

-- region visual mode
-- Execute selected lua code
utils.set_vkey("r", ":lua<CR>")

-- copy selection
utils.set_vkey("y", ":CopySelection<CR>")
-- endregion visual mode
