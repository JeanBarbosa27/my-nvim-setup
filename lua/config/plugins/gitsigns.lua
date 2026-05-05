local mappings = require("config.gitsigns.mappings")

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "|" },
        },
        signcolumn = true,
        numhl = false,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text_pos = "eol",
          delay = 300,
        },
        -- base = "main", -- uncomment to always diff against main instead of index.
        -- Also can use:
        --   - to set globally via `:Gitsigns change_base main true` command
        --   - to change it per buffer via `:Gitsigns change_base main` command
      }
      mappings.set_normal_key_maps()
    end,
  }
}
