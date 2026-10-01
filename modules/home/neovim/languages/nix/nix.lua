lspconfig.nixd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        nixd = {
            formatting = {
                command = { "nixfmt" },
            },
        },
    },
}
