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
in
{
  options.neovim.treesitter.grammars = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Tree-sitter grammars contributed by language modules.";
  };

  config = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs;
        lib.optionals pkgs.stdenv.isLinux [
          (if config.wayland.enable then wl-clipboard else xclip)
        ];

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
        ${builtins.readFile ./lua/common.lua}
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
          config = toLua (builtins.readFile ./lua/neo-tree.lua);
        }

        {
          plugin = onedarker-nvim;
          config = toLua (builtins.readFile ./lua/colorscheme.lua);
        }

        {
          plugin = comment-nvim;
          config = toLua (builtins.readFile ./lua/comment.lua);
        }

        nvim-treesitter
        nvim-treesitter-refactor

        {
          plugin = (
            nvim-treesitter.withPlugins (
              p:
              [
                p.tree-sitter-vim
                p.tree-sitter-bash
                p.tree-sitter-python
              ]
              ++ map (name: p.${name}) config.neovim.treesitter.grammars
            )
          );
        }

        {
          plugin = telescope-nvim;
          config = toLua (builtins.readFile ./lua/telescope.lua);
        }

        telescope-fzf-native-nvim
      ];
    };
  };
}
