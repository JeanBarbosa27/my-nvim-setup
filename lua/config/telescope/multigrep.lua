local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

local utils = require("config.utils")

local M = {}

local function get_parent_folders(parent_amount)
  return function(_, path)
    local parts = {}
    for part in string.gmatch(path, "[^/]+") do
      table.insert(parts, part)
    end

    local start = math.max(1, #parts - parent_amount)
    return table.concat(parts, "/", start)
  end
end

local function build_path_display(parent_depth)
  -- e.g. parent_depth = 2 -> "grandparent/parent/file.ext"
  if parent_depth > 0 then
    return get_parent_folders(parent_depth)
  end

  return { shorten = 3 }
end

local live_multigrep = function(opts)
  local parent_depth = (opts or {}).parent_depth or 0
  opts = themes.get_ivy(opts or {})
  opts.cwd = opts.cwd or vim.uv.cwd()
  opts.path_display = build_path_display(parent_depth)

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

      return vim.iter({
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
      }):flatten():totable()
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
  utils.set_nkey("fg", live_multigrep,
    { desc = "Find text through the project (glob filter, shortened path)" })
  utils.set_nkey(
    "fG",
    function() live_multigrep({ parent_depth = 2 }) end,
    { desc = "Find text through the project using (glob filenter, last 2 parent folders)" })
end

return M
