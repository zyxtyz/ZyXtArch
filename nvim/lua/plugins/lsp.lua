-- lua/plugins/lsp.lua

-- temporarily disable notifications to hide deprecation warnings
local notify_old = vim.notify
vim.notify = function(...) end

-- list of servers
local servers = {
    lua_ls = {},
    pyright = {},
    ts_ls = {},
    rust_analyzer = {},
    clangd = {},
    bashls = {},
    cssls = {},
    html = {},
    taplo = {},
    nixd = {},
}

-- setup servers using vim.lsp.config
for server, opts in pairs(servers) do
    local lspconfig = vim.lsp.configs
    if not lspconfig[server] then
        -- fallback to require('lspconfig') if needed
        lspconfig = require("lspconfig")
    end
    lspconfig[server].setup(opts)
end

-- restore notifications
vim.notify = notify_old
