vim.g.mapleader = " "
vim.opt.shortmess:append("I")  -- hides the intro message

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.termguicolors = false

local ok, _ = pcall(require, "plugins.lsp")
if not ok then
  -- silently ignore errors/warnings
end

-- lazy.nvim path
local lazypath = vim.fn.expand("~/.config/zyxtarch/nvim/lazy/lazy.nvim")
vim.opt.rtp:prepend(lazypath)

-- Folder where your plugin configs live
local plugins_path = "~/.config/zyxtarch/nvim/lua/plugins/"

-- Correct plugins path
local plugins_path = vim.fn.expand("~/.config/zyxtarch/nvim/lua/plugins/")
-- or using stdpath:
-- local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins/"

require("lazy").setup(
    {
        {
            "neovim/nvim-lspconfig",
            config = function()
                dofile(plugins_path .. "lsp.lua")
            end
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                dofile(plugins_path .. "treesitter.lua")
            end
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                dofile(plugins_path .. "telescope.lua")
            end
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip",
                "L3MON4D3/LuaSnip"
            },
            config = function()
                dofile(plugins_path .. "cmp.lua")
            end
        },
    },

    {
        root = vim.fn.stdpath("config") .. "/lazy/plugins",
        lockfile = vim.fn.stdpath("config") .. "/lazy/lazy-lock.json",
        state = vim.fn.stdpath("config") .. "/lazy/state.json",
        readme = { root = vim.fn.stdpath("config") .. "/lazy/readme" },
    }
)