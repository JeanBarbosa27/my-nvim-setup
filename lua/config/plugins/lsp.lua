local mappings = require("config.lsp.mappings")

-- This function is used to enable the folding via LSP. It's usefull to fold yaml and Python (which are indent based)
local function enable_folding_expression()
  vim.o.foldmethod = "expr"
  -- vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
end

local function setup_language_servers()
  -- Global defaults applied to every server
  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  })

  vim.lsp.config("ltex", {
    settings = {
      ltex = {
        language = "en-GB",
        dictionary = {
          ["en-GB"] = { "NeoVim", "nvim" },
        },
      },
    },
    filetypes = { "markdown", "text", "gitcommit" },
  })

  vim.lsp.config("lua_ls", {})
  vim.lsp.config("yamlls", {})
  vim.lsp.config("html", { filetypes = { "html", "xml" } })
  vim.lsp.config("lemmix", { filetypes = { "xml", "xsd", "xsl", "xslt" } })

  vim.lsp.config("pyright", {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
        }
      }
    }
  })

  vim.lsp.config("kotlin_language_server", {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      local group = vim.api.nvim_create:augroup("kotlin_organize_imports_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" }, diagnostics = {} },
            apply = true,
          })
        end,
      })
    end,
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = { "lua", "python" }, -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      setup_language_servers()
      enable_folding_expression()

      -- Auto format the file when it's saved
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client then return end

          -- Set LSP mappings
          mappings.set_nkey_mappings(args)

          if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  }
}
