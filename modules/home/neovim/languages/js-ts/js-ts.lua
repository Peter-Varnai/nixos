lspconfig.ts_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
        completions = {
            completeFunctionCalls = true,
        },
    },
}

lspconfig.eslint.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("bufwritepre", {
            buffer = bufnr,
            callback = function()
                client:request_sync("workspace/executeCommand", {
                    command = "eslint.applyAllFixes",
                    arguments = {{
                        uri = vim.uri_from_bufnr(bufnr),
                        version = vim.lsp.util.buf_versions[bufnr],
                    }},
                }, 3000, bufnr)
            end,
        })
    end,
    settings = {
        eslint = {
            codeAction = {
                disableRuleComment = { enable = true },
                showDocumentation = { enable = true },
            },
        },
    },
}

vim.api.nvim_create_autocmd("filetype", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})
