return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "echasnovski/mini.icons",
    },
    config = function()
      require "octo".setup({ picker = "telescope" })
    end
  }
}
