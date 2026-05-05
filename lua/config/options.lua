local set = vim.opt

set.clipboard = "unnamedplus"
set.colorcolumn = "122"
set.number = true
set.relativenumber = true
set.updatetime = 100
set.wrap = true

vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "gray", bg = "gray" })
