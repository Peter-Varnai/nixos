{
  config,
  pkgs,
  lib,
  ...
}:
let
  toLua = str: ''
    lua << EOF
    ${str}
    EOF
  '';
  # toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [ wl-clipboard ];
    extraConfig = ''
      set autoread
      set updatetime=1000

      augroup auto_reload
        autocmd!
        autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
      augroup END
    '';

    extraLuaConfig = ''
      ${builtins.readFile ./lua/options.lua}
      ${builtins.readFile ./lua/keymaps.lua}
      ${builtins.readFile ./lua/devicons.lua}
      ${builtins.readFile ./lua/cmp.lua}
      ${builtins.readFile ./lua/lsp.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      lspkind-nvim
      luasnip
      cmp_luasnip
      plenary-nvim
      nvim-web-devicons
      nui-nvim
      {
        plugin = neo-tree-nvim;
        config = toLua ''
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
        '';
      }
      {
        plugin = onedarker-nvim;
        config = "colorscheme onedarker";
      }
      {
        plugin = comment-nvim;
        config = toLua "require('Comment').setup()";
      }

      nvim-treesitter
      nvim-treesitter-refactor

      {
        plugin = (
          nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-rust
            p.javascript
            p.typescript
            p.tsx
          ])
        );
      }

      {
        plugin = telescope-nvim;
        config = toLua ''
              require('telescope').setup({
                      extensions = {
                      fzf = {
                          fuzzy = true,                    
                          override_generic_sorter = true, 
                          override_file_sorter = true,   
                          case_mode = "smart_case",     
                      }
                  }
              })

          require('telescope').load_extension('fzf')
        '';
      }

      telescope-fzf-native-nvim
    ];
  };
}
