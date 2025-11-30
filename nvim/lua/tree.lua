-----------------------------------------------------------
-- nvim-tree: updated and fixed for "nvim ." startup
-----------------------------------------------------------

-- Disable netrw (required)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setup
require("nvim-tree").setup({
  hijack_netrw = true,

  -- prevent auto-open behavior that conflicts with startup logic
  hijack_directories = {
    enable = false,
    auto_open = false,
  },
})

-----------------------------------------------------------
-- Open nvim-tree when starting Neovim in a directory (nvim .)
-----------------------------------------------------------
local function open_nvim_tree(data)
  -- check if the buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- create a new empty buffer
  vim.cmd.enew()

  -- wipe the directory buffer
  vim.cmd.bw(data.buf)

  -- change to that directory
  vim.cmd.cd(data.file)

  -- open nvim-tree in a normal split, not fullscreen
  require("nvim-tree.api").tree.open({
    current_window = false,
  })
end

vim.api.nvim_create_autocmd("VimEnter", { callback = open_nvim_tree })
