return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- add "rust_analyzer" here to install rust, for example
        ensure_installed = {
          "lua_ls",
          "kotlin_language_server",
          "yamlls",
        }
      })
    end
  }
}
