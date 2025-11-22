require("nvim-treesitter.configs").setup({
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    ensure_installed = {
        "yuck", "asm", "c", "cpp", "css", "html", "xml", "toml",
        "rust", "lua", "python", "javascript", "typescript", "bash", "nix"
    },
    auto_install = true
})
