local set = vim.keymap.set

-- normal mode mappings
set("n", "<space><space>r", "<cmd>source %<CR>")
set("n", "<space>r", ":.lua<CR>")
set("n", "<space>x", ":bd<CR>")

-- visual mode mappings
set("v", "<space>r", ":lua<CR>")
