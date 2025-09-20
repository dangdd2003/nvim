return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- mdx as markdown
    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)

      vim.filetype.add({
        extension = {
          mdx = "markdown.mdx",
        },
      })
      vim.treesitter.language.register("markdown", "markdown.mdx")
    end,
  },
}
