local utils = require("config.utils")
local M = {}

function M.set_normal_key_maps()
  local gs = require("gitsigns")

  -- hunk navigation
  utils.set_key("n", "]c", function() gs.nav_hunk("next") end, { desc = "Next git hunk" })
  utils.set_key("n", "[c", function() gs.nav_hunk("prev") end, { desc = "Previous hunk" })

  -- hunk actions
  utils.set_nkey("hp", function() gs.preview_hunk() end, { desc = "Preview hunk" })
  utils.set_nkey("hs", function() gs.stage_hunk() end, { desc = "Stage hunk" })
  utils.set_nkey("hr", function() gs.reset_hunk() end, { desc = "Reset hunk" })
  utils.set_nkey("hS", function() gs.stage_buffer() end, { desc = "Stage buffer" })
  utils.set_nkey("hR", function() gs.reset_buffer() end, { desc = "Reset buffer" })
  utils.set_nkey("hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
  utils.set_nkey("hd", function() gs.diffhis() end, { desc = "Diff against index (git uncommitted changes)" })
  utils.set_nkey("hD", function() gs.diffhis("~") end, { desc = "Diff against last commit" })

  -- toggles
  utils.set_nkey("tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
  utils.set_nkey("td", gs.toggle_deleted, { desc = "Toggle deleted lines" })
end

return M
