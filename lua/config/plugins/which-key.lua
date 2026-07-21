return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<space>b",  group = "Buffers" },
        { "<space>c",  group = "Copy" },
        { "<space>cd", group = "Copy directory operations" },
        { "<space>cf", group = "Copy file operations" },
        { "<space>cr", group = "Copy root project operations" },
        { "<space>C",  group = "Code" },
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
