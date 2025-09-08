local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")

local utils = require("config.utils")

local M = {}
local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then return nil end

      local pieces = vim.split(prompt, "%s%s+")
      local term = pieces[1]
      local multi_globs = pieces[2]
      local args = { "rg" }

      if term and term ~= "" then
        table.insert(args, "-e")
        table.insert(args, term)
      end

      if multi_globs and multi_globs ~= "" then
        local globs = vim.split(multi_globs, ",")
        for _, glob in ipairs(globs) do
          if glob ~= "" then
            table.insert(args, "-g")
            table.insert(args, glob)
          end
        end
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd
  }

  pickers.new(opts, {
    debounce = 150,
    finder = finder,
    previewer = conf.grep_previewer(opts),
    prompt_title = "Live grep with extension filter",
    sorter = sorters.empty(),
  }):find()
end

M.setup = function()
  utils.set_nkey("fg", live_multigrep)
end

return M
