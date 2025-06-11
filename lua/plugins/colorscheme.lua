-- available configured colorschemes: "tokyonight", "catppuccin", "solarized-osaka", "solarized",
-- "everforest", "gruvbox", "gruvbox-material", "kanagawa", "rose-pine", "monokai-pro"(cost very long time to load),
-- "onedark", "onedarkpro","material", "nightfox", "nightfly", "moonfly"
local colorscheme = "catppuccin" -- <---- set colorscheme here

local lazyvim = {
  "LazyVim/LazyVim",
  opts = {
    colorscheme = colorscheme,
  },
}

if colorscheme == "tokyonight" then
  return {
    lazyvim,
    {
      "folke/tokyonight.nvim",
      priority = 1000,
      opts = {
        style = "storm",
        transparent = false,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        -- custom line number color
        on_highlights = function(highlights, colors)
          highlights.LineNr = { fg = colors.purple }
          highlights.LineNrAbove = { fg = colors.purple }
          highlights.LineNrBelow = { fg = colors.purple }
        end,
      },
    },
  }
elseif colorscheme == "catppuccin" then
  return {
    lazyvim,
    {
      "catppuccin/nvim",
      priority = 1000,
      name = "catppuccin",
      opts = {
        flavour = "macchiato",
        transparent_background = true,
        term_colors = true,
        integrations = {
          nvim_surround = true,
        },
        -- custom line number color
        custom_highlights = function(c)
          return {
            CursorLineNr = { fg = c.rosewater },
            FloatBorder = { fg = c.maroon },
            LineNr = { fg = c.mauve },
            TelescopeTitle = { fg = c.base, bg = c.yellow },
            TelescopePromptBorder = { fg = c.flamingo },
            TelescoperesultsBorder = { fg = c.pink },
            TelescopePreviewBorder = { fg = c.sapphire },
            FzfLuaTitle = { fg = c.base, bg = c.yellow },
            FzfLuaTtitePromptBorder = { fg = c.flamingo },
            FzfLuaPreviewBorder = { fg = c.sapphire },
          }
        end,
      },
    },
  }
elseif colorscheme == "solarized-osaka" then
  return {
    lazyvim,
    {
      "craftzdog/solarized-osaka.nvim",
      priority = 1000,
      opts = {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        on_highlights = function(hl, c)
          hl.TelescopeBorder = hl.FloatBorder
          hl.TelescopeTitle = { fg = c.base04, bg = c.green }
          hl.FzfLuaBorder = hl.FloatBorder
          hl.FzfLuaTitle = { fg = c.base04, bg = c.green }
          hl.FzfLuaPreviewTitle = { fg = c.base04, bg = c.cyan300 }
        end,
      },
    },
  }
elseif colorscheme == "solarized" then
  return {
    lazyvim,
    {
      "maxmx03/solarized.nvim",
      priority = 1000,
      opts = {
        transparent = {
          enabled = false,
        },
        -- palette = "selenized",
        variant = "autumn",
        styles = {
          comments = { italic = true, bold = false },
          functions = { italic = true },
        },
      },
    },
  }
elseif colorscheme == "everforest" then
  return {
    lazyvim,
    {
      "neanias/everforest-nvim",
      priority = 1000,
      config = function()
        require("everforest").setup({
          transparent_background_level = 0, -- { 0, 1, 2 }
          italics = true,
          inlay_hints_background = "dimmed",
          on_highlights = function(hl, pl)
            hl.FloatBorder = { bg = pl.none }
            hl.TelescopeTitle = { fg = pl.bg0, bg = pl.yellow }
            hl.TelescopePromptBorder = { fg = pl.red }
            hl.TelescoperesultsBorder = { fg = pl.blue }
            hl.TelescopePreviewBorder = { fg = pl.purple }
          end,
        })
      end,
    },
  }
elseif colorscheme == "gruvbox" then
  return {
    lazyvim,
    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      opts = {
        -- transparent_mode = true,
        overrides = {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          GruvboxBlueSign = { bg = "none" }, -- remove bg boder for "noice.nvim" cmdline popup
        },
      },
    },
  }
elseif colorscheme == "gruvbox-material" then
  return {
    lazyvim,
    {
      "sainnhe/gruvbox-material",
      priority = 1000,
      config = function()
        vim.g.gruvbox_material_background = "soft"
        vim.g.gruvbox_material_transparent_background = false
        vim.g.gruvbox_material_enable_italic = true
        vim.g.gruvbox_material_visual = "reverse"
        vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
        vim.g.gruvbox_material_inlay_hints_background = "dimmed"
        -- transparent floating border and window background
        vim.api.nvim_create_autocmd("ColorScheme", {
          callback = function()
            -- vim.o.background = "light"
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
          end,
        })
      end,
    },
  }
elseif colorscheme == "kanagawa" then
  return {
    lazyvim,
    {
      "rebelot/kanagawa.nvim",
      priority = 1000,
      opts = {
        transparent = false,
        theme = "dragon",
        background = {
          dark = "dragon",
          light = "lotus",
        },
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            TelescopeBorder = { bg = "none" },
          }
        end,
      },
    },
  }
elseif colorscheme == "rose-pine" then
  return {
    lazyvim,
    {
      "rose-pine/neovim",
      priority = 1000,
      name = "rose-pine",
      opts = {
        dark_variant = "moon",
        styles = {
          transparency = false,
        },
        highlight_groups = {
          LineNr = { fg = "iris" },
          CursorLineNr = { fg = "rose" },
          TelescopeBorder = { fg = "rose", bg = "none" },
          TelescopeTitle = { fg = "love" },
          TelescopeNormal = { bg = "none" },
          TelescopeSelection = { bg = "highlight_med" },
          TelescopeSelectionCaret = { bg = "highlight_med" },
        },
      },
    },
  }
elseif colorscheme == "monokai-pro" then
  return {
    lazyvim,
    {
      "loctvl842/monokai-pro.nvim",
      priority = 1000,
      keys = { { "<leader>C", "<cmd>MonokaiProSelect<cr>", desc = "Select Monokai pro filter" } },
      opts = {
        transparent_background = false,
        filter = "octagon", -- "classic" | "octagon" | "pro" | "machine" | "ristretto" | "spectrum"
        background_clear = {
          "float_win",
          "toggleterm",
          "telescope",
          "which-key",
          "renamer",
          "notify",
          "neo-tree",
          "bufferline",
        },
      },
    },
  }
elseif colorscheme == "onedark" then
  return {
    lazyvim,
    {
      "navarasu/onedark.nvim",
      priority = 1000,
      keys = {
        {
          "<leader>ut",
          function()
            require("onedark").toggle()
          end,
          desc = "Onedark theme toggle",
        },
      },
      opts = {
        style = "warmer", -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
        transparent = false,
        highlights = {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
        },
      },
    },
  }
elseif colorscheme == "onedarkpro" then
  lazyvim.opts.colorscheme = "onedark" -- "onedark" | "onedark_dark" | "onedark_vivid" | "onelight"
  return {
    lazyvim,
    {
      "olimorris/onedarkpro.nvim",
      priority = 1000,
      opts = {
        options = {
          transparency = false,
          terminal_colors = true,
        },
        styles = {
          comments = "italic",
          functions = "italic",
          keywords = "bold",
          types = "italic,bold",
          conditionals = "italic",
        },
        highlights = {
          TelescopeBorder = { bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopeSelectionCaret = { fg = "red" },
          FloatBorder = { bg = "None" },
        },
      },
    },
  }
elseif colorscheme == "material" then
  return {
    lazyvim,
    {
      "marko-cerovac/material.nvim",
      priority = 1000,
      keys = {
        {
          "<leader>ut",
          function()
            require("material.functions").toggle_style()
          end,
          desc = "Material theme toggle",
        },
        {
          "<leader>th",
          function()
            require("material.functions").find_style()
          end,
          desc = "Material find style",
        },
        {
          "<leader>t1",
          function()
            require("material.functions").change_style("darker")
          end,
          desc = "Material Darker theme",
        },
        {
          "<leader>t2",
          function()
            require("material.functions").change_style("lighter")
          end,
          desc = "Material Lighter theme",
        },
        {
          "<leader>t3",
          function()
            require("material.functions").change_style("deep ocean")
          end,
          desc = "Material Deep Ocean theme",
        },
        {
          "<leader>t4",
          function()
            require("material.functions").change_style("oceanic")
          end,
          desc = "Material Oceanic theme",
        },
        {
          "<leader>t5",
          function()
            require("material.functions").change_style("palenight")
          end,
          desc = "Material Palenight theme",
        },
      },
      opts = {
        disable = {
          colored_cursor = true,
          background = false,
        },
        -- lualine_style = "stealth", -- should use with transparent
      },
      config = function(_, opts)
        require("material").setup(opts)
        vim.g.material_style = "deep ocean" -- "darker" | "lighter" | "deep ocean" | "oceanic" | "palenight"
      end,
    },
  }
elseif colorscheme == "nightfox" then
  lazyvim.opts.colorscheme = "nightfox" -- "nightfox" | "dayfox" | "dawnfox" | "duskfox" | "nordfox" | "terafox" | "carbonfox"
  return {
    lazyvim,
    {
      "EdenEast/nightfox.nvim",
      priority = 1000,
      opts = {
        options = {
          transparent = false,
          styles = {
            comments = "italic",
            functions = "italic",
            keywords = "bold",
            types = "italic,bold",
            conditionals = "italic",
          },
        },
        groups = {
          all = {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
          },
        },
      },
    },
  }
elseif colorscheme == "nightfly" then
  return {
    lazyvim,
    {
      "bluz71/vim-nightfly-colors",
      priority = 1000,
      name = "nightfly",
      config = function()
        vim.g.nightflyCursorColor = true
        vim.g.nightflyNormalFloat = true
        vim.g.nightflyTransparent = false
        vim.g.nightflyVirtualTextColor = true
      end,
    },
  }
elseif colorscheme == "moonfly" then
  return {
    lazyvim,
    {
      "bluz71/vim-moonfly-colors",
      priority = 1000,
      name = "moonfly",
      config = function()
        vim.g.moonflyCursorColor = true
        vim.g.moonflyNormalFloat = true
        vim.g.moonflyTransparent = false
        vim.g.moonflyVirtualTextColor = true
      end,
    },
  }
else
  LazyVim.warn('Unknown colorscheme "' .. colorscheme .. '"! Fall back to defalt', { title = "Colorscheme 🌈" })
  return {}
end
