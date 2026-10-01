local function toggle_neotree()
    if vim.bo.filetype == "neo-tree" then
        require("neo-tree.command").execute({ action = "close" })
    else
        require("neo-tree.command").execute({ action = "focus", source = "filesystem" })
    end
end
vim.keymap.set('n', '<M-1>', toggle_neotree, { noremap = true, silent = true })

require('neo-tree').setup({
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            visible = true,
            hide_gitignored = false,
            show_hidden_count = true,
            hide_dotfiles = false,
        },
    },
})
