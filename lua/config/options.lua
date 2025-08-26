local set = vim.opt

set.number = true
set.relativenumber = true
set.colorcolumn = "122"
set.clipboard = "unnamedplus"
set.wrap = true

vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "gray", bg = "gray" })
