return {
  {
    "plasticboy/vim-markdown",
    dependencies = { "godlygeek/tabular" },
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_folding_disabled = 0
      vim.g.vim_markdown_conceal = 2
    end
  }
}
