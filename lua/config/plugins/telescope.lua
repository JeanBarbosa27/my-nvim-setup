local telescope_key_maps = require("config.telescope.mappings")

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      }
    },
    config = function()
      require("telescope").setup {
        pickers = {
          buffers = {
            theme = "ivy",
            sort_mru = true,
            ignore_current_buffer = true,
            sort_lastused = true,
          },
          current_buffer_fuzzy_find = { theme = "ivy" },
          find_files = { theme = "ivy" },
          help_tags = { theme = "ivy" },
          lsp_references = { theme = "ivy" },
          live_grep = { theme = "ivy" },
        },
        extensions = {
          fzf = {}
        }
      }

      require("telescope").load_extension("fzf")
      require("config.telescope.multigrep").setup()

      telescope_key_maps.set_normal_key_maps()
    end
  }
}
