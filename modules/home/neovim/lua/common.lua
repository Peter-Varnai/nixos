-- Thin shim over the nvim 0.11 API so `lspconfig.<server>.setup {}` keeps working
-- without the deprecated require('lspconfig') framework (nvim-lspconfig still
-- supplies the default per-server configs).
lspconfig = setmetatable({}, {
    __index = function(_, server)
        return {
            setup = function(config)
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end,
        }
    end,
})
capabilities = require('cmp_nvim_lsp').default_capabilities()

on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>gd', function()
        vim.lsp.buf.definition({ reuse_win = true })
    end, { buffer = bufnr })
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = bufnr })

    if client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end
