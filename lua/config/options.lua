-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore = { "*/node_modules/*,node_modules/*", "*/__pycache__/*,__pycache__/*", "*/.git/*,.git/*" }
vim.opt.formatoptions:append({ "r" })
-- vim.opt.guicursor = "n-v-i-c:block-Cursor"

vim.g.ai_cmp = false
vim.g.snacks_animate = false
vim.g.lazyvim_picker = "fzf"

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- deafaut terminal for windows
if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("pwsh")
end

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
