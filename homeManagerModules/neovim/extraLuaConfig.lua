vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.o.signcolumn = 'yes'
vim.opt.expandtab = true
vim.cmd [[highlight! link signcolumn normal]]
vim.api.nvim_set_hl(0, "statusline", { link = "normal" })
vim.api.nvim_set_hl(0, "statuslinenc", { link = "normal" })
vim.api.nvim_set_hl(0, "msgarea", { link = "normal" })
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = false
vim.opt.wrap = true
vim.opt.mouse = 'a'
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.cmdheight = 1
vim.opt.breakindent = false
vim.opt.scrolloff = 4
-- vim.opt.guicursor = ""

vim.g.mapleader = " "

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("grep > ") });
end)

vim.api.nvim_set_hl(0, "normal", { bg = "none" })
vim.api.nvim_set_hl(0, "normalfloat", { bg = "none" })

require("nvim-web-devicons").setup({
    default = true
})

local cmp = require 'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- lsp completions
        { name = 'luasnip' },  -- snippet completions
    }, {
        { name = 'buffer' },   -- buffer completions (words from the current file)
    }),

    mapping = cmp.mapping.preset.insert({
        -- confirm selection
        ['<cr>'] = cmp.mapping.confirm({ select = true }), -- accept currently selected item

        -- navigate items in the list
        ['<c-n>'] = cmp.mapping.select_next_item(), -- next item
        ['<c-p>'] = cmp.mapping.select_prev_item(), -- previous item

        -- scroll docs (if available)
        ['<c-d>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),

        -- snippet expansion
        ['<c-e>'] = cmp.mapping.abort(), -- close completion window
    }),
})


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

-- example for typescript (using tsserver)
lspconfig.ts_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- example for rust (using rust_analyzer)
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

-- html lsp (vscode-html-language-server)
lspconfig.html.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

-- css lsp (vscode-css-language-server)
lspconfig.cssls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

-- nix lsp (nil)
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

-- glsl configuration
lspconfig.glsl_analyzer.setup {
    capabilities = capabilities,
    filetypes = { "glsl", "vert", "frag", "comp", "tesc", "tese", "geom" },
    on_attach = on_attach
}

-- chatgpt keymaps
vim.keymap.set("n", "<leader>cc", "<cmd>chatgpt<cr>")
vim.keymap.set({ "n", "v" }, "<leader>ce", "<cmd>chatgpteditwithinstruction<cr>")
vim.keymap.set({ "n", "v" }, "<leader>cg", "<cmd>chatgptrun grammar_correction<cr>")
vim.keymap.set({ "n", "v" }, "<leader>ct", "<cmd>chatgptrun translate<cr>")
vim.keymap.set({ "n", "v" }, "<leader>ck", "<cmd>chatgptrun keywords<cr>")
vim.keymap.set({ "n", "v" }, "<leader>cd", "<cmd>chatgptrun docstring<cr>")
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>chatgptrun add_tests<cr>")
vim.keymap.set({ "n", "v" }, "<leader>co", "<cmd>chatgptrun optimize_code<cr>")
vim.keymap.set({ "n", "v" }, "<leader>cs", "<cmd>chatgptrun summarize<cr>")
vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>chatgptrun fix_bugs<cr>")
vim.keymap.set({ "n", "v" }, "<leader>cx", "<cmd>chatgptrun explain_code<cr>")
vim.keymap.set({ "n", "v" }, "<leader>cr", "<cmd>chatgptrun roxygen_edit<cr>")
vim.keymap.set({ "n", "v" }, "<leader>cl", "<cmd>ChatGPTRun code_readability_analysis<CR>")
