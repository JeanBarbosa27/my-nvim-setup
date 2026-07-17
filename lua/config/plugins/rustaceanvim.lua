return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- pins to the current major. Check the repo for the latest if want to update
    lazy = false,   -- rustaceanvim is a filetype plugin, it manages its own loading
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              check = { command = "clippy" },
            },
          },
          on_attach = function(_, bufnr)
            -- Rust-specific keymaps
            vim.keymap.set(
              "n", "<space>Rc",
              function() vim.cmd.RustLsp("codeAction") end,
              { buffer = bufnr, desc = "Rust: Code action (grouped)" }
            )
            vim.keymap.set(
              "n", "<space>Rr",
              function() vim.cmd.RustLsp("runnables") end,
              { buffer = bufnr, desc = "Rust: Runnables (cargo run / test)" }
            )
          end
        },
      }
    end
  }
}
