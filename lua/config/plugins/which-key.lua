return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<space>b",  group = "Buffers" },
        { "<space>c",  group = "Copy / Code" },
        { "<space>cf", group = "Copy file operations" },
        { "<space>d",  group = "Debug / Diff View" },
        { "<space>db", group = "Debug options" },
        { "<space>dv", group = "Diff View" },
        { "<space>e",  group = "Editor" },
        { "<space>f",  group = "find (telescope)" },
        { "<space>h",  group = "Diff hunk" },
        { "<space>r",  group = "rust / run" },
      }
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
