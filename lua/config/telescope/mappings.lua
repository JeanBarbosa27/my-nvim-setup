local utils = require("config.utils")

local M = {}

function M.find_in_buffer(builtins)
  -- find buffers
  utils.set_nkey("fb", builtins.buffers)

  -- find symbols
  utils.set_nkey("fs", builtins.lsp_document_symbols, { desc = "Find symbols in current buffer" })

  -- find references
  utils.set_nkey("fr", builtins.lsp_references)

  -- find text
  utils.set_nkey("ft", builtins.current_buffer_fuzzy_find)
end

function M.find_in_workspace(builtins)
  -- find files in project root
  utils.set_nkey("fp", function()
    builtins.find_files({ hidden = true })
  end)

  -- find files in current file directory
  utils.set_nkey("fd", function()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir = vim.fn.fnamemodify(current_file, ":h")
    builtins.find_files({ cwd = current_dir, prompt_title = "Files in current directory", hidden = true })
  end)

  -- find text
  utils.set_nkey("F", function()
    builtins.live_grep({ hidden = true })
  end
  )

  -- find symbols
  utils.set_nkey("fw", builtins.lsp_workspace_symbols, { desc = "Find symbos in current workspace" })
end

function M.find_config_files(builtins)
  -- find editor config
  utils.set_nkey("ec", function() builtins.find_files({ cwd = vim.fn.stdpath("config") }) end)

  -- find editor packages
  utils.set_nkey("ep", function()
    builtins.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") }
  end)

  -- ssh config
  local ssh_folder = "~/.ssh"
  utils.set_nkey("es", function()
    vim.cmd.edit(vim.fs.joinpath(ssh_folder, "/config"))
  end, { desc = "Edit ssh config" })

  utils.set_nkey("sc", function()
    builtins.find_files { cwd = ssh_folder }
  end, { desc = "Find in SSH config" })

  -- edit zsh config
  utils.set_nkey("ez", function() vim.cmd.edit("~/.zshrc") end, { desc = "Edit zsh config" })

  -- find zsh config
  utils.set_nkey("zc", function()
    builtins.find_files { cwd = "~/.config/zsh", hidden = true }
  end)

  -- find Telescope help tags
  utils.set_nkey("fh", builtins.help_tags)
end

function M.lsp_diagnostics(builtins)
  utils.set_nkey("cm", function()
    builtins.diagnostics({ bufnr = 0 })
  end, { desc = "Diagnostics for current buffer" })
end

function M.set_normal_key_maps()
  -- check out for ":Telescope builtin" for more builtin function references
  local builtins = require("telescope.builtin")

  M.find_in_buffer(builtins)
  M.find_in_workspace(builtins)
  M.find_config_files(builtins)
  M.lsp_diagnostics(builtins)
end

return M
