lspconfig = require 'lspconfig'
capabilities = require('cmp_nvim_lsp').default_capabilities()

on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})

    if client.supports_method("textdocument/formatting") then
        vim.api.nvim_create_autocmd("bufwritepre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end
