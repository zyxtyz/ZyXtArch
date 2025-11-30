vim.g.mapleader = " "
vim.opt.shortmess:append("I")

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.termguicolors = false
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1


local plug_path = vim.fn.stdpath("config") .. "/plug/plug.vim"

local config_dir = vim.fn.stdpath("config") .. "/lua"

for _, file in ipairs(vim.fn.readdir(config_dir)) do
  if file:match("%.lua$") then
    local module = file:gsub("%.lua$", "")
    require(module)
  end
end

if vim.fn.empty(vim.fn.glob(plug_path)) > 0 then
  vim.fn.system({
    "sh", "-c",
    "curl -fLo " .. plug_path .. " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  })
end

vim.cmd("source " .. plug_path)



-- Plugins
vim.cmd [[
call plug#begin(stdpath('config') . '/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-tree.lua'


call plug#end()
]]