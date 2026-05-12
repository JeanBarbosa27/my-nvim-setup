return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "LspAttach", -- load only when LSP is active
    opts = {
      backend = "vim",   -- keep it simple and stable
      picker = "telescope",
    },
    keys = {
      {
        "<space>ca",
        function() require("tiny-code-action").code_action({}) end,
        mode = { "n", "x" },
        desc = "Show code actions",
      }
    },
  }
}
