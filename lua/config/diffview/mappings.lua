local utils = require("config.utils")
local M = {}

-- region helper functions
local function openView(branch_name)
  if branch_name == nil then
    vim.cmd("DiffviewOpen")
    print("Opened diff view for uncommitted git changes")
    return
  end

  local branch_comparison = branch_name .. "...HEAD"
  vim.cmd("DiffviewOpen " .. branch_comparison)
  print("Opened diff view for changes on " .. branch_name)
end

local function closeView()
  vim.cmd("DiffviewClose")
  print("Closed diff view")
end

local function currentFileHistory()
  vim.cmd("DiffviewFileHistory %")
  print("Opened diff view for currend file history")
end

local function repoFileHistory()
  vim.cmd("DiffviewFileHistory")
  print("Opened diff view for repository file history")
end
-- endregion helper functions

-- region public API
function M.set_normal_key_maps()
  -- working tree vs index (git uncommited changes)
  utils.set_nkey("dvo", openView, { desc = "Open DiffView for working tree vs index (git uncommited changes)" })
  utils.set_nkey("dvc", closeView, { desc = "Close Diffview" })

  -- review my branch as a PR against main
  utils.set_nkey("dvm", function() openView("main") end, { desc = "Open Diffview comparing current branch vs main" })

  -- review my branch as a PR against master
  utils.set_nkey("dvmo", function() openView("master") end, { desc = "Open Diffview comparing branch vs master" })

  -- file history
  utils.set_nkey("dvh", currentFileHistory, { desc = "Open Difffview with the history of the current file" })
  utils.set_nkey("dvH", repoFileHistory, { desc = "Open Diffview with the repository's file history" })
end

-- endregion public API

return M
