local M = {}

function M.setup()
  local plugin = require "window-picker"
  local colors = require "nitintf.theme.palette"
  local view = require "nitintf.utils.view"

  plugin.setup {
    selection_chars = view.window_picker_keys,
    filter_rules = {
      autoselect_one = true,
      include_current_win = false,
      bo = {
        -- if the file type is one of following, the window will be ignored
        filetype = { "neo-tree", "neo-tree-popup", "notify" },

        -- if the buffer type is one of following, the window will be ignored
        buftype = { "terminal", "quickfix" },
      },
    },
    highlights = {
      statusline = {
        focused = {
          fg = colors.bg,
          bg = colors.cyan,
          bold = true,
        },
        unfocused = {
          fg = colors.bg,
          bg = colors.cyan,
          bold = true,
        },
      },
      winbar = {
        focused = {
          fg = colors.bg,
          bg = colors.cyan,
          bold = true,
        },
        unfocused = {
          fg = colors.bg,
          bg = colors.cyan,
          bold = true,
        },
      },
    },
  }
end

return M
