-- This function is used to enable the folding via LSP. It's usefull to fold yaml and Python (which are indent based)
local function enable_folding_expression()
  vim.o.foldmethod = "expr"
  -- vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
end

local organise_imports_on_save_for = {
  kotlin_language_server = true,
  ruff = true,
  gopls = true,
  -- ts_ls = true, -- uncomment when adding TypeScript support
}

-- region LSP helpers
-- Set up autocmd that asks the LSP to organise imports on every save.
--
---@param client vim.lsp.Client The LSP client (the you one got from `on_attach` / LspAttach).
---@param bufnr integer         Buffer the autocmd is local to.
---@param opts? {kind?: string} Kind: LSP code action kind. Defaults to "source.organizeImports".
local function organise_imports_on_save(client, bufnr, opts)
  opts = opts or {}
  local kind = opts.kind or "source.organizeImports"

  if not client:supports_method("textDocument/codeAction") then return end

  local organise_import_group = vim.api.nvim_create_augroup(
    ("lsp_organize_imports_%d_%d"):format(client.id, bufnr),
    { clear = true }
  )

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = organise_import_group,
    buffer = bufnr,
    desc = ("LSP %s: %s on save"):format(client.name, kind),
    callback = function()
      vim.lsp.buf.code_action({
        context = { only = { kind }, diagnostics = {} },
        apply = true,
      })
    end
  })
end
-- endregion LSP helpers

-- WARN: don't ever add "rust_analyzer" to `setup_language_servers` function. It's managed by `rustaceanvim` plugin,
-- doing so would add multiple rust clients at the same buffer.
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
          ["en-GB"] = {
            "Golang",
            "NeoVim",
            "Neovim",
            "Octo",
            "Ripgrep",
            "neovim",
            "nvim",
            "octo",
            "ripgrep",
          },
        },
      },
    },
    filetypes = { "markdown", "text", "gitcommit" },
  })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } }, --only `vim` is allowed
      },
    },
  })
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
          -- let ruff handle these:
          diagnosticSeverityOverrides = {
            reportUnusedImport     = "none",
            reportUnusedVariable   = "none",
            reportUnusedExpression = "none",
          },
        }
      }
    }
  })
  vim.lsp.config("ruff", {})

  vim.lsp.config("kotlin_language_server", {
    on_attach = function(client, _)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })

  vim.lsp.config("gopls", {
    settings = {
      gopls = {
        staticcheck = true,
        gofumpt = true,
        hints = { parametersNames = true, assignVariableTypes = true },
      },
    },
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
        group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client then return end

          -- Organise imports on save for language server from organise_imports_on_save table
          if organise_imports_on_save_for[client.name] then
            organise_imports_on_save(client, args.buf)
          end

          -- Shows parameter names and inferred types
          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end

          -- Autoformat on save
          if client:supports_method("textDocument/formatting") then
            local current_buffer = args.buf
            local format_group = vim.api.nvim_create_augroup(
              ("lsp_format_%d_%d"):format(client.id, current_buffer),
              { clear = true }
            )
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = format_group,
              buffer = current_buffer,
              callback = function()
                vim.lsp.buf.format({ bufnr = current_buffer, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  }
}
