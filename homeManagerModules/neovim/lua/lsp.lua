local lspconfig = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
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
                vim.lsp.buf.format({ async = false })
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

lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            checkonsave = {
                command = "clippy",
            },
        },
    },
}

lspconfig.html.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

lspconfig.cssls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

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

lspconfig.glsl_analyzer.setup {
    capabilities = capabilities,
    filetypes = { "glsl", "vert", "frag", "comp", "tesc", "tese", "geom" },
    on_attach = on_attach
}
