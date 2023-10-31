local M = {}

function M.setup()
  local plugin = require "telescope"
  local actions = require "telescope.actions"
  local fb = require "telescope._extensions.file_browser.actions"

  local function copy_path(bufnr, fmt)
    local fs = require "nitintf.utils.fs"
    local clipboard = require "nitintf.utils.clipboard"
    local fb_utils = require "telescope._extensions.file_browser.utils"

    local selections = fb_utils.get_selected_files(bufnr, true)
    local entry = selections[1]

    if entry ~= nil then
      local result = fs.format(entry.filename, fmt)

      if result ~= nil then
        clipboard.yank(result)
        print("Copied to clipboard: " .. result)
        vim.defer_fn(function() vim.cmd.echo('""') end, 5000)
      end
    else
      vim.api.nvim_err_writeln("No file selected")
    end
  end

  local extensions = {
    file_browser = {
      -- path
      -- cwd
      cwd_to_path = false,
      grouped = false,
      files = true,
      add_dirs = true,
      depth = 1,
      auto_depth = false,
      select_buffer = false,
      hidden = { file_browser = false, folder_browser = false },
      respect_gitignore = false,
      -- browse_files
      -- browse_folders
      hide_parent_dir = false,
      collapse_dirs = false,
      prompt_path = false,
      quiet = false,
      dir_icon = "",
      dir_icon_hl = "Default",
      display_stat = false,
      hijack_netrw = false,
      use_fd = true,
      git_status = true,
      mappings = {
        ["i"] = {
          ["<D-n>"] = fb.create,
          ["<S-CR>"] = fb.create_from_prompt,
          ["<D-r>"] = fb.rename,
          ["<D-m>"] = fb.move,
          ["<D-d>"] = fb.copy,
          ["<D-BS>"] = fb.remove,
          ["<D-o>"] = fb.open,
          ["<D-u>"] = fb.goto_parent_dir,
          ["<D-M-u>"] = fb.goto_cwd,
          ["<D-f>"] = fb.toggle_browser,
          ["<D-h>"] = fb.toggle_hidden,
          ["<D-a>"] = fb.toggle_all,
          ["<BS>"] = fb.backspace,
          ["<CR>"] = "select_default",
          ["<C-c>"] = false,
          ["<A-c>"] = false,
          ["<A-r>"] = false,
          ["<A-m>"] = false,
          ["<A-y>"] = false,
          ["<A-d>"] = false,
          ["<C-o>"] = false,
          ["<C-g>"] = false,
          ["<C-e>"] = false,
          ["<C-w>"] = false,
          ["<C-t>"] = false,
          ["<C-f>"] = false,
          ["<C-h>"] = false,
          ["<C-s>"] = false,
          ["<C-d>"] = false,
          ["<C-u>"] = false,
        },
        ["n"] = {
          ["<D-n>"] = fb.create,
          ["<S-CR>"] = fb.create_from_prompt,
          ["<D-r>"] = fb.rename,
          ["<D-m>"] = fb.move,
          ["<D-d>"] = fb.copy,
          ["<D-BS>"] = fb.remove,
          ["<D-o>"] = fb.open,
          ["<D-u>"] = fb.goto_parent_dir,
          ["<D-M-u>"] = fb.goto_cwd,
          ["<D-f>"] = fb.toggle_browser,
          ["<D-h>"] = fb.toggle_hidden,
          ["<D-a>"] = fb.toggle_all,
          ["ya"] = function(bufnr) copy_path(bufnr, "absolute") end,
          ["yr"] = function(bufnr) copy_path(bufnr, "relative") end,
          ["yn"] = function(bufnr) copy_path(bufnr, "filename") end,
          ["ys"] = function(bufnr) copy_path(bufnr, "filestem") end,
          ["a"] = false,
          ["c"] = false,
          ["g"] = false,
          ["r"] = false,
          ["m"] = false,
          ["y"] = false,
          ["d"] = false,
          ["o"] = false,
          ["u"] = false,
          ["e"] = false,
          ["w"] = false,
          ["t"] = false,
          ["f"] = false,
          ["h"] = false,
          ["s"] = false,
          ["L"] = false,
          ["H"] = false,
          ["<C-d>"] = false,
          ["<C-u>"] = false,
        },
      },
    },
  }

  plugin.setup {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          width = 0.8,
          preview_width = 0.5,
        },
        vertical = {
          width = 0.5,
          height = 0.7,
          preview_cutoff = 1,
          prompt_position = "top",
          preview_height = 0.4,
          mirror = true,
        },
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "%.git/", "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" },       -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = {
          ["<D-Down>"] = actions.file_split,
          ["<D-Right>"] = actions.file_vsplit,
          ["<C-t>"] = actions.preview_scrolling_up,
          ["<C-h>"] = actions.preview_scrolling_down,
          ["<D-w>"] = actions.close,
        },
        i = {
          ["<D-Down>"] = actions.file_split,
          ["<D-Right>"] = actions.file_vsplit,
          ["<C-t>"] = actions.preview_scrolling_up,
          ["<C-h>"] = actions.preview_scrolling_down,
          ["<D-w>"] = actions.close,
        },
      },
    },
    pickers = {
      buffers = {
        mappings = {
          n = { ["<D-BS>"] = actions.delete_buffer },
          i = { ["<D-BS>"] = actions.delete_buffer },
        },
      },
    },
    extensions = extensions,
  }

  pcall(function()
    for ext, _ in pairs(extensions) do
      plugin.load_extension(ext)
    end
  end)
end

return M
