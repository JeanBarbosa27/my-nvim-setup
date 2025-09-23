local utils = require("config.utils")

local M = {}

function M.set_normal_key_maps()
  utils.set_key("n", "-", "<cmd>Oil<CR>")
end

return M
