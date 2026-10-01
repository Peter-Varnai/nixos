lspconfig.lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        lua = {
            diagnostics = { globals = { "vim" } },
            format = { enable = true },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkthirdparty = false,
            },
        },
    },
}
