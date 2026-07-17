return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- WARN: don't ever add "rust_analyzer" to `ensure_installed` table. It's managed by `rustaceanvim` plugin, doing
      -- so would add multiple rust clients at the same buffer.
      ensure_installed = {
        "gopls",
        "html",
        "kotlin_language_server",
        "lemminx",
        "ltex",
        "lua_ls",
        "pyright",
        "ruff",
        "yamlls",
      },
      automatic_enable = {
        exclude = { "rust_analyzer" },
      },
    },
  }
}
