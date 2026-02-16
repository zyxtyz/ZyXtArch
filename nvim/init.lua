-- ============================================================================  
-- SUPPRESS STARTUP WARNINGS  
-- ============================================================================  
  
-- Suppress intro message and various warnings  
vim.opt.shortmess:append('I')  -- No intro message  
vim.opt.shortmess:append('W')  -- No "written to" warnings  
vim.opt.shortmess:append('a')  -- No attention messages  
vim.opt.shortmess:append('o')  -- Overwrite file messages  
vim.opt.shortmess:append('O')  -- File-read message overwrites previous  
vim.opt.shortmess:append('s')  -- No "search hit BOTTOM" messages  
vim.opt.shortmess:append('t')  -- Truncate file messages  
vim.opt.shortmess:append('T')  -- Truncate other messages  
vim.opt.shortmess:append('f')  -- No file info when editing  
vim.opt.shortmess:append('F')  -- No file info when editing  
  
-- Early notification filter (before plugins load)  
local original_notify = vim.notify  
vim.notify = function(msg, level, opts)  
  -- Suppress common startup warnings  
  if msg:match('No information available') then return end  
  if msg:match('No code actions available') then return end  
  if msg:match('client .* is not responding') then return end  
  if msg:match('LSP.*: server initialization failed') then return end  
  if msg:match('Warning: Cannot convert string') then return end  
    
  original_notify(msg, level, opts)  
end  
  
-- ============================================================================  
-- BASIC SETTINGS  
-- ============================================================================  
  
vim.g.mapleader = ' '  
vim.g.maplocalleader = ' '  
vim.opt.number = true  
vim.opt.relativenumber = true  
vim.opt.expandtab = true  
vim.opt.tabstop = 4 
vim.opt.shiftwidth = 4  
vim.opt.smartindent = true  
vim.opt.swapfile = false  
vim.opt.backup = false  
vim.opt.writebackup = false  
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'  
vim.opt.undofile = true  
vim.opt.hlsearch = false  
vim.opt.incsearch = true  
vim.opt.termguicolors = false  
vim.opt.scrolloff = 8  
vim.opt.signcolumn = 'yes'  
vim.opt.updatetime = 50  
vim.opt.colorcolumn = '0'  
vim.opt.guioptions = vim.opt.guioptions - 'r' - 'l' - 'b'

  
-- ============================================================================  
-- PACKAGE MANAGER (lazy.nvim)  
-- ============================================================================  
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'  
if not vim.loop.fs_stat(lazypath) then  
  vim.fn.system({  
    'git',  
    'clone',  
    '--filter=blob:none',  
    'https://github.com/folke/lazy.nvim.git',  
    '--branch=stable',  
    lazypath,  
  })  
end  
vim.opt.rtp:prepend(lazypath)  
  
require('lazy').setup({  
  -- Tree-sitter  
  {  
    'nvim-treesitter/nvim-treesitter',  
    build = ':TSUpdate',  
    opts = {  
      ensure_installed = {  
        'lua', 'vim', 'vimdoc', 'query',  
        'python', 'cpp', 'typescript', 'tsx', 'javascript',  
        'bash', 'fish', 'nix'  
      },  
      highlight = { enable = true },  
      indent = { enable = true },  
    }  
  },  
  
  -- File Explorer  
  {  
    'nvim-tree/nvim-tree.lua',  
    dependencies = { 'nvim-tree/nvim-web-devicons' },  
    opts = {  
      view = {  
        side = 'left',  
        width = 30,  
        preserve_window_proportions = true,  
      },  
      renderer = {  
        group_empty = true,  
        indent_markers = {  
          enable = true,  
        },  
      },  
      filters = {  
        dotfiles = false,  
      },  
    }  
  },  
  
  -- fzf  
  {  
    'ibhagwan/fzf-lua',  
    dependencies = { 'nvim-tree/nvim-web-devicons' },  
    opts = {}  
  },  
  
  -- LSP config  
  {  
    'neovim/nvim-lspconfig',  
    config = function()  
      -- Define LSP server configurations using new Neovim 0.11 API [1](#14-0)   
      vim.lsp.config['pylsp'] = {  
        cmd = { 'pylsp' },  
        filetypes = { 'python' },  
        root_markers = { '.git', 'pyproject.toml', 'setup.py', 'requirements.txt' },  
        settings = {  
          pylsp = {  
            plugins = {  
              pycodestyle = { enabled = true },  
              pyflakes = { enabled = true },  
              pylint = { enabled = false },  
            }  
          }  
        }  
      }  
  
      vim.lsp.config['clangd'] = {  
        cmd = { 'clangd', '--background-index', '--clang-tidy' },  
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },  
        root_markers = { '.git', 'compile_commands.json', '.clangd' },  
      }  
  
      vim.lsp.config['ts_ls'] = {  
        cmd = { 'typescript-language-server', '--stdio' },  
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },  
        root_markers = { '.git', 'package.json', 'tsconfig.json' },  
      }  
  
      vim.lsp.config['bashls'] = {  
        cmd = { 'bash-language-server', 'start' },  
        filetypes = { 'sh', 'bash', 'zsh' },  
        root_markers = { '.git' },  
      }  
  
      vim.lsp.config['nil_ls'] = {  
        cmd = { 'nil' },  
        filetypes = { 'nix' },  
        root_markers = { '.git', 'flake.nix' },  
      }  
  
      -- Enable all configured LSP servers  
      vim.lsp.enable('pylsp')  
      vim.lsp.enable('clangd')  
      vim.lsp.enable('ts_ls')  
      vim.lsp.enable('bashls')  
      vim.lsp.enable('nil_ls')  
    end  
  },  
  
  -- Optional: Add more useful plugins  
  {  
    'nvim-telescope/telescope.nvim',  
    tag = '0.1.5',  
    dependencies = { 'nvim-lua/plenary.nvim' },  
    opts = {}  
  },  
  
  {  
    'hrsh7th/nvim-cmp',  
    dependencies = {  
      'hrsh7th/cmp-nvim-lsp',  
      'hrsh7th/cmp-buffer',  
      'hrsh7th/cmp-path',  
    },  
    opts = {  
      sources = {  
        { name = 'nvim_lsp' },  
        { name = 'buffer' },  
        { name = 'path' },  
      },  
    },  
    config = function(_, opts)  
      local cmp = require('cmp')  
      opts.mapping = cmp.mapping.preset.insert({  
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),  
        ['<C-f>'] = cmp.mapping.scroll_docs(4),  
        ['<C-Space>'] = cmp.mapping.complete(),  
        ['<C-e>'] = cmp.mapping.abort(),  
        ['<CR>'] = cmp.mapping.confirm({ select = true }),  
      })  
      cmp.setup(opts)  
    end  
  },  
})  
  
-- ============================================================================  
-- TREE-SITTER CONFIGURATION  
-- ============================================================================  
vim.treesitter.language.register('bash', { 'zsh', 'sh' })  
  
-- ============================================================================  
-- LSP KEYMAPS  
-- ============================================================================  
vim.api.nvim_create_autocmd('LspAttach', {  
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),  
  callback = function(ev)  
    local opts = { buffer = ev.buf }  
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)  
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)  
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)  
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)  
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)  
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)  
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)  
    vim.keymap.set('n', '<space>wl', function()  
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))  
    end, opts)  
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)  
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)  
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)  
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)  
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)  
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)  
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)  
  end,  
})  
  
-- ============================================================================  
-- NVIM-TREE KEYMAPS  
-- ============================================================================  
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle NvimTree' })  
vim.keymap.set('n', '<leader>f', '<cmd>NvimTreeFocus<cr>', { desc = 'Focus NvimTree' })  
vim.keymap.set('n', '<leader>o', '<cmd>NvimTreeFindFile<cr>', { desc = 'Find file in NvimTree' })  
  
-- ============================================================================  
-- FZF KEYMAPS  
-- ============================================================================  
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = 'Find files' })  
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua live_grep<cr>', { desc = 'Live grep' })  
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { desc = 'Find buffers' })  
vim.keymap.set('n', '<leader>fh', '<cmd>FzfLua help_tags<cr>', { desc = 'Help tags' })  
  
-- ============================================================================  
-- TELESCOPE KEYMAPS (alternative to fzf)  
-- ============================================================================  
vim.keymap.set('n', '<leader>tf', '<cmd>Telescope find_files<cr>', { desc = 'Telescope find files' })  
vim.keymap.set('n', '<leader>tg', '<cmd>Telescope live_grep<cr>', { desc = 'Telescope live grep' })  
vim.keymap.set('n', '<leader>tb', '<cmd>Telescope buffers<cr>', { desc = 'Telescope buffers' })  
  
-- ============================================================================  
-- WINDOW RESIZING  
-- ============================================================================  
vim.keymap.set('n', '<leader>=', '<C-w>5>', { desc = 'Increase window width' })  
vim.keymap.set('n', '<leader>-', '<C-w>5<', { desc = 'Decrease window width' })  
  
-- ============================================================================  
-- SHELL SCRIPT CONFIGURATION  
-- ============================================================================  
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {  
  pattern = { '*.zsh', '.zshrc', '.zprofile', '.zshenv' },  
  callback = function()  
    vim.bo.filetype = 'zsh'  
  end,  
})  
  
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {  
  pattern = { '*.fish', '.config/fish/*.fish' },  
  callback = function()  
    vim.bo.filetype = 'fish'  
  end,  
})  
  
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {  
  pattern = { '*.nix' },  
  callback = function()  
    vim.bo.filetype = 'nix'  
  end,  
})  
  
-- ============================================================================  
-- DIAGNOSTIC CONFIGURATION  
-- ============================================================================  
vim.diagnostic.config({  
  virtual_text = true,  
  signs = true,  
  underline = true,  
  update_in_insert = false,  
  severity_sort = true,  
})  
  
-- ============================================================================  
-- AUTO-OPEN NVIM-TREE  
-- ============================================================================  
vim.api.nvim_create_autocmd('VimEnter', {  
  callback = function()  
    if vim.fn.argc() == 0 then  
      require('nvim-tree.api').tree.open()  
    end  
  end,  
})  
  
-- ============================================================================  
-- UTILITY FUNCTIONS  
-- ============================================================================  
vim.keymap.set('n', '<leader>n', function()  
  vim.opt.relativenumber = not vim.opt.relativenumber:get()  
end, { desc = 'Toggle relative numbers' })  
  
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save' })  
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })  
  
-- ============================================================================  
-- AUTOCOMMANDS  
-- ============================================================================  
-- Highlight when yanking (copying) text  
vim.api.nvim_create_autocmd('TextYankPost', {  
  desc = 'Highlight when yanking (copying) text',  
  callback = function()  
    vim.hl.on_yank()  
  end,  
})