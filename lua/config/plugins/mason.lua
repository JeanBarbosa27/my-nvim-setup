return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
	ensure_installed = { "lua-language-server" }, -- add "rust-analyzer" here to install rust, for example
	automatic_installation = true,
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" } -- add "rust_analyzer" here to install rust, for example
      })
    end
  }
}
