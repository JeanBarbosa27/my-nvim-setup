return {
  {
    'echasnovski/mini.nvim',
    enabled = true,
    config = function()
      local statusline = require("mini.statusline")
      local indentscope = require("mini.indentscope")

      statusline.setup({
        use_icons = true,
        content = {
          -- Override the active statusline layout
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git           = statusline.section_git({ trunc_width = 40 })
            local diff          = statusline.section_diff({ trunc_width = 75 })
            local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
            local lsp           = statusline.section_lsp({ trunc_width = 75 })

            -- Combine path relative to root directory + file status
            local filename      = vim.fn.expand('%:.')
            if filename == '' then filename = '[No Name]' end

            local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
            local location = statusline.section_location({ trunc_width = 75 })
            local search   = statusline.section_searchcount({ trunc_width = 75 })

            return statusline.combine_groups({
              { hl = mode_hl,                 strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
              '%<', -- truncate point
              { hl = 'MiniStaqtuslineFilename', strings = { filename } },
              '%=', -- end of left alignment
              { hl = 'MiniStatuslineFileinfo',  strings = { fileinfo } },
              { hl = mode_hl,                   strings = { search, location } },
            })
          end,
        },
      })

      indentscope.setup {
        symbol = "|",
        draw = {
          delay = 50,
          animation = indentscope.gen_animation.none(),
          options = { try_as_border = true },
        },
      }
    end
  }
}
