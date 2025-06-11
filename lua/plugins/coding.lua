return {
  {
    "zbirenbaum/copilot.lua",
    optional = true,
    opts = {
      suggestion = {
        keymap = {
          accept_word = "<M-w>",
          accept_line = "<M-l>",
          dismiss = "<M-d>",
        },
      },
      filetypes = {
        yaml = true,
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      {
        "<leader>am",
        function()
          return require("CopilotChat").select_model()
        end,
        desc = "Select Model (CopilotChat)",
        mode = { "n" },
      },
    },
    opts = {
      model = "claude-3.7-sonnet",
      temperature = 0.5,
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = {
          enabled = true,
        },
      },
    },
  },
}
