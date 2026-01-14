local function auto_organize_imports()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.java",
    callback = function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.organizeImports" },
          diagnostics = {},
        },
        apply = true,
      })
    end
  })
end

return {
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("java").setup({
        jdk = {
          auto_install = false,
          version = 21,
        },
        jdtls = {
          settings = {
            java = {
              imports = {
                gradle = {
                  wrapper = {
                    checksums = {
                      {
                        sha256 = "423cb469ccc0ecc31f0e4e1c309976198ccb734cdcbb7029d4bda0f18f57e8d9",
                        allowed = true
                      }
                    }
                  }
                }
              }
            }
          },
        },
        java_test = {
          enable = true,
        },
        java_debug_adapter = {
          enable = true,
        },
        spring_boot_tools = {
          enable = true,
        },
      })

      auto_organize_imports()
    end,
  }
}
