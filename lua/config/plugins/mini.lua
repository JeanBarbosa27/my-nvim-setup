return {
  {
    'echasnovski/mini.nvim',
    enabled = true,
    config = function()
      local statusline = require("mini.statusline")
      local indentscope = require("mini.indentscope")

      statusline.setup { use_icons = true }
      indentscope.setup {
        symbol = "|",
        dray = {
          delay = 50,
          animation = indentscope.gen_animation.none(),
          options = { try_as_border = true },
        },
      }
    end
  }
}
