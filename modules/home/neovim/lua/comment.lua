require('Comment').setup({
  -- Comment.nvim's own treesitter commentstring lookup crashes on recent
  -- neovim (unparsed tree is nil), surfacing as "[Comment.nvim] nil".
  -- Use the commentstring neovim already resolved from the ftplugin instead.
  pre_hook = function()
    local cs = vim.bo.commentstring
    if cs:find('%%s') then
      return cs
    end
  end,
})
