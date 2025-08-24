function set_normal_key_maps()
  local set = vim.keymap.set
  -- check out for ":Telescope builtin" for more builtin function references
  local builtins = require("telescope.builtin")

  -- find buffers
  set("n", "<space>fb", builtins.buffers)

  -- find directory
  set("n", "<space>fd", builtins.find_files)

  -- find editor config
  set("n", "<space>ec", function()
    builtins.find_files({ cwd = vim.fn.stdpath("config") })
  end)

  -- find editor packages
  set("n", "<space>ep", function()
    builtins.find_files {
      cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
    }
  end)

  -- find help tags
  set("n", "<space>fh", builtins.help_tags)

  -- find references
  set("n", "<space>fr", builtins.lsp_references)

  -- find text in the current buffer
  set("n", "<space>ft", builtins.current_buffer_fuzzy_find)

  -- find text in the current project
  set("n", "<space>F", builtins.live_grep)
end

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
          buffers = { theme = "ivy" },
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
      set_normal_key_maps()
    end
  }
}
