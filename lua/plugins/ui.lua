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
        elseif (vim.g.colors_name or ""):find("rose-pine") then
          return require("rose-pine.plugins.bufferline")
        elseif (vim.g.colors_name or ""):find("catppuccin") then
          local c = require("catppuccin.palettes").get_palette()
          if require("catppuccin").options.transparent_background then
            return apply_bg(c.base)
          end
        elseif (vim.g.colors_name or ""):find("solarized-osaka") then
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
      opts.presets.lsp_doc_border = true
      opts.presets.bottom_search = false
    end,
  },

  -- notification
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        style = "fancy",
      },
    },
  },

  -- indentation guide
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = {
        include = {
          node_type = {
            lua = {
              "table_constructor",
            },
          },
        },
      },
    },
  },

  -- dashboard - startup UI
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      -- local logo = [[
      --   ██████╗       ██████╗ ███████╗██╗   ██╗          Z
      --   ██╔══██╗      ██╔══██╗██╔════╝██║   ██║      Z
      --  ████╗ ██║█████╗██║  ██║█████╗  ██║   ██║   z
      --  ╚██╔╝ ██║╚════╝██║  ██║██╔══╝  ╚██╗ ██╔╝ z
      --   ██████╔╝      ██████╔╝███████╗ ╚████╔╝
      --   ╚═════╝       ╚═════╝ ╚══════╝  ╚═══╝
      -- ]]

      local logo = [[
       ____      _                                       
      |  _ \  __| | __ _ _ __   __ ___      __          Z
      | | | |/ _` |/ _` | '_ \ / _` \ \ /\ / /      Z    
      | |_| | (_| | (_| | | | | (_| |\ V  V /    z       
      |____/ \__,_|\__,_|_| |_|\__, | \_/\_/   z         
                               |___/                     
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local file_browser = function()
        local fb_actions = require("telescope").extensions.file_browser
        fb_actions.file_browser()
      end

      opts.config.header = vim.split(logo, "\n")
      table.remove(opts.config.center, 7)
      table.insert(opts.config.center, 2, {
        action = file_browser,
        desc = "  File Browser",
        icon = "󰥨",
        key = "b",
      })
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
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
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.diagnostic.config({
        float = { border = "rounded" },
      })
    end,
  },

  -- mason
  {
    "williamboman/mason.nvim",
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
      elseif (vim.g.colors_name or ""):find("solarized-osaka") then
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
            { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
          }
          return buffer
        end,
      })
    end,
  },
}
