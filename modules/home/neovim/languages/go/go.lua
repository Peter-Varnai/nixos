lspconfig.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
}

lspconfig.golangci_lint_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function(args)
        local params = vim.lsp.util.make_range_params(0, "utf-16")
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 3000)
        for client_id, res in pairs(result or {}) do
            local client = vim.lsp.get_client_by_id(client_id)
            for _, action in pairs(res.result or {}) do
                if action.edit then
                    vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                end
            end
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "gomod" },
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})
