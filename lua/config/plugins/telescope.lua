function set_normal_key_maps()
  local set = vim.keymap.set
  -- check out for ":Telescope builtin" for more builtin function references
  local builtins = require("telescope.builtin")

  -- find buffers
  set("n", "<space>fb", builtins.buffers)

  -- find files in project root
  set("n", "<space>fD", builtins.find_files)

  -- find files in current file directory
  set("n", "<space>fd", function()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir = vim.fn.fnamemodify(current_file, ":h")
    builtins.find_files({
      cwd = current_dir,
      prompt_title = "Files in current directory",
    })
  end)

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

  -- ssh config
  local ssh_folder = "~/.ssh"

  set("n", "<space>es", function()
    vim.cmd.edit(vim.fs.joinpath(ssh_folder, "/config"))
  end, { desc = "Edit ssh config" })

  set("n", "<space>sc", function()
    builtins.find_files { cwd = ssh_folder }
  end, { desc = "Find in SSH config" })

  -- edit zsh config
  set("n", "<space>ez", function()
    vim.cmd.edit("~/.zshrc")
  end, { desc = "Edit zsh config" })

  -- find zsh config
  set("n", "<space>zc", function()
    builtins.find_files { cwd = "~/.config/zsh", hidden = true }
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

      set_normal_key_maps()
    end
  }
}
