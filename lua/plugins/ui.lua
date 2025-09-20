return {

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    keys = function()
      return {
        { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Tab" },
        { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Tab" },
        { "<leader><Tab>p", "<Cmd>BufferLinePick<CR>", desc = "Pick Tab" },
      }
    end,
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
      highlights = function()
        local highlight = {}
        local values = {
          "close_button",
          "tab",
          "tab_separator",
          "buffer",
          "duplicate",
          "hint",
          "hint_diagnostic",
          "info",
          "info_diagnostic",
          "error",
          "error_diagnostic",
          "warning",
          "warning_diagnostic",
          "modified",
          "separator",
          "pick",
        }
        local function apply_bg(color)
          for _, value in ipairs(values) do
            highlight[value .. "_selected"] = { bg = color }
          end
          return highlight
        end
        if (vim.g.colors_name or ""):find("tokyonight") then
          local c = require("tokyonight.colors").setup()
          if require("tokyonight.config").options.transparent then
            return apply_bg(c.bg_highlight)
          end
        elseif (vim.g.colors_name or ""):find("rose%-pine") then
          return require("rose-pine.plugins.bufferline")
        elseif (vim.g.colors_name or ""):find("catppuccin") then
          local c = require("catppuccin.palettes").get_palette()
          if require("catppuccin").options.transparent_background then
            return apply_bg(c.base)
          end
        elseif (vim.g.colors_name or ""):find("solarized%-osaka") then
          local c = require("solarized-osaka.colors").setup()
          if require("solarized-osaka.config").options.transparent then
            return apply_bg(c.base03)
          end
        end
      end,
    },
  },

  -- noice
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, {
        filter = {
          event = "lsp",
          kind = "progress",
          find = "jdtls",
        },
        opts = { skip = true },
      })
      opts.presets.bottom_search = false
    end,
  },

  -- Most global UI config
  {
    "folke/snacks.nvim",
    opts = {
      animate = {
        fps = 144,
      },
      notifier = {
        style = "fancy",
      },
      scroll = {
        enabled = false,
      },
      dim = {
        animate = {
          enabled = false,
        },
      },
    },
  },

  -- dashboard - startup UI
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard.preset.header = [[
  _____      _                            
 |  __ \    | |                           
 | |  | | __| | __ _ _ __   __ ___      __
 | |  | |/ _` |/ _` | '_ \ / _` \ \ /\ / /
 | |__| | (_| | (_| | | | | (_| |\ V  V / 
 |_____/ \__,_|\__,_|_| |_|\__, | \_/\_/  
                            __/ |         
                           |___/          
          ]]
      table.remove(opts.dashboard.preset.keys, 7)
      if LazyVim.has("telescope-file-browser.nvim") then
        table.insert(opts.dashboard.preset.keys, 2, {
          icon = "󰥩 ",
          key = "b",
          desc = "File Browser",
          action = ":Telescope file_browser",
        })
        table.insert(opts.dashboard.preset.keys, 7, {
          icon = "󰆧 ",
          key = "p",
          desc = "Plugin",
          action = function()
            require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
          end,
        })
      end
      if LazyVim.has("fzf-lua") then
        table.insert(opts.dashboard.preset.keys, 6, {
          icon = "󰆧 ",
          key = "p",
          desc = "Plugin",
          action = function()
            require("fzf-lua").files({ cwd = require("lazy.core.config").options.root })
          end,
        })
      end
    end,
  },

  -- lualine - statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
      },
    },
  },

  -- lsp floating border
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function()
  --     vim.diagnostic.config({
  --       float = { border = "rounded" },
  --     })
  --   end,
  -- },

  -- mason
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        border = "rounded",
        height = 0.75,
      },
    },
  },

  -- incline - filename
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      local highlight
      if (vim.g.colors_name or ""):find("catppuccin") then
        local c = require("catppuccin.palettes").get_palette()
        highlight = {
          groups = {
            InclineNormal = { guibg = c.rosewater, guifg = c.overlay0 },
            InclineNormalNC = { guibg = c.surface1, guifg = c.lavender },
          },
        }
      elseif (vim.g.colors_name or ""):find("solarized%-osaka") then
        local c = require("solarized-osaka.colors").setup()
        highlight = {
          groups = {
            InclineNormal = { guibg = c.yellow100, guifg = c.base03 },
            InclineNormalNC = { guibg = c.violet700, guifg = c.base3 },
          },
        }
      elseif (vim.g.colors_name or ""):find("tokyonight") then
        local c = require("tokyonight.colors").setup()
        highlight = {
          groups = {
            InclineNormal = { guibg = c.blue2, guifg = c.fg_gutter },
            InclineNormalNC = { guibg = c.terminal_black, guifg = c.purple },
          },
        }
      else
        highlight = {
          groups = {
            InclineNormal = { guibg = "#C71585", guifg = "#F2F3F4" },
            InclineNormalNC = { guibg = "#C0C0C0", guifg = "#8000FF" },
          },
        }
      end
      require("incline").setup({
        highlight = highlight,
        window = {
          margin = { vertical = 1, horizontal = 0 },
        },
        hide = {
          cursorline = true,
        },
      })
      require("incline").setup({
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"

          if vim.bo[props.buf].modified then
            filename = filename .. ""
          end

          local function get_diagnostic_label()
            local icons = require("lazyvim.config").icons.diagnostics
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "┊ " })
            end
            return label
          end

          local buffer = {
            { get_diagnostic_label() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename .. " ", gui = modified },
            { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
          }
          return buffer
        end,
      })
    end,
  },
}
