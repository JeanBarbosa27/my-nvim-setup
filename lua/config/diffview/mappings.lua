local utils = require("config.utils")
local M = {}

function M.set_normal_key_maps()
  -- working tree vs index (git uncommited changes)
  utils.set_nkey("dvo", "<cmd>DiffviewOpen<CR>", { desc = "Diffview: open" })
  utils.set_nkey("dvc", "<cmd>DiffviewClose<CR>", { desc = "Diffview: close" })

  -- review my branch as a PR against main
  utils.set_nkey("dvm", "<cmd>DiffviewOpen main...HEAD<CR>", { desc = "Diffview: review branch vs main" })

  -- review my branch as a PR against master
  utils.set_nkey("dvmo", "<cmd>DiffviewOpen master...HEAD<CR>", { desc = "Diffview: review branch vs master" })

  -- file history
  utils.set_nkey("dvh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Difffview: history of currenty file" })
  utils.set_nkey("dvH", "<cmd>DiffviewFileHistory<CR>", { desc = "Diffview: history of repo" })
end

return M
