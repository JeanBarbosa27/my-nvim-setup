local mappings = require("config.oil.mappings")

return {
  {
    "stevearc/oil.nvim",
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = {
      {
        "echasnovski/mini.icons",
        opts = {}
      }
    },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require("oil").setup {
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
        preview_win = {
          update_on_cursor_moved = true, -- Auto-update preview when cursor moves
          preview_mode = "fast_scratch", -- "load" | "scratch" | "fast_scratch"
          disable_preview = function(filename)
            -- If want to skip preview for specific files, return true on a if statement
            return false
          end,
          win_options = {}, -- Window-local options for the preview buffer
        },
        mappings.set_normal_key_maps()
      }
    end
  }
}
