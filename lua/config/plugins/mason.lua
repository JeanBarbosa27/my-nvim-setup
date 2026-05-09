return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "html",
        "kotlin_language_server",
        "lemminx",
        "lua_ls",
        "pyright",
        "yamlls",
      },
      automatic_enable = true,
    },
  }
}
