return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-telescope/telescope-file-browser.nvim" },
  keys = {
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
    {
      "fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
    {
      "fb",
      function()
        local fb_actions = require("telescope").extensions.file_browser
        fb_actions.file_browser()
      end,
      desc = "File Browser (current buffer)",
    },

    -- short binding find
    { "fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", desc = "Find All Files" },
    { "fc", LazyVim.pick.config_files(), desc = "Find Config File" },
    { "ff", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
    { "fF", LazyVim.pick("auto", { root = false }), desc = "Find Files (cwd)" },
    { "fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
    { "fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    { "fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "fw", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    { "fW", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
  },
  opts = function()
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions
    local function telescope_buffer_dir()
      return vim.fn.expand("%:p:h")
    end
    return {
      pickers = {
        find_files = {
          follow = true,
        },
      },

      defaults = {
        wrap_result = true,
        winblend = 0,
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },

        preview = {
          filesize_limit = 10, -- MB
        },

        mappings = {
          n = {
            ["q"] = require("telescope.actions").close,
            ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
          },
          i = {
            ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
          },
        },
      },

      extensions = {
        file_browser = {
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          follow_symlinks = true,
          grouped = true,
          previewer = false,
          theme = "dropdown",
          initial_mode = "normal",
          hijack_netrw = true,
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            height = 0.80,
            preview_cutoff = 120,
          },
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          mappings = {
            ["n"] = {
              ["h"] = fb_actions.goto_parent_dir,
              ["<bs>"] = fb_actions.goto_parent_dir,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 5 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 5 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("file_browser")
  end,
}
