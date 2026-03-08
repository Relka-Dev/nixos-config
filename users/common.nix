{ pkgs, nixvim, ... }:
{
  imports = [ nixvim.homeManagerModules.nixvim ];
  home.stateVersion = "25.05";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 50;
      splitright = true;
      splitbelow = true;
    };

    globals.mapleader = " ";

    keymaps = [
      # Navigation fichiers
      {
        mode = "n";
        key = "<leader>e";
        action = ":Yazi<CR>";
        options.desc = "Ouvrir Yazi";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Chercher fichiers";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Buffers";
      }
      # LSP
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Aller à la définition";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "Hover doc";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "Code action";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "Renommer";
      }
      # Splits
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
      }
      # Misc
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Sauvegarder";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quitter";
      }
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Déplacer ligne bas";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Déplacer ligne haut";
      }
    ];

    plugins = {
      # UI
      lualine.enable = true;
      bufferline.enable = true;
      indent-blankline.enable = true;
      which-key.enable = true;
      noice.enable = true;

      # Navigation
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };

      # Yazi intégration
      yazi.enable = true;

      # Git
      gitsigns.enable = true;
      lazygit.enable = true;

      # Treesitter
      treesitter = {
        enable = true;
        settings.highlight.enable = true;
        grammarPackages =
          with pkgs.vscode-extensions;
          [ ]
          ++ (with pkgs.tree-sitter-grammars; [
          ]);
      };

      # Autocomplétion
      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
        };
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      luasnip.enable = true;

      # LSP
      lsp = {
        enable = true;
        servers = {
          # Python
          pyright.enable = true;
          ruff.enable = true;
          # Nix
          nil-ls.enable = true;
          # Web
          ts-ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          # Général
          jsonls.enable = true;
          yamlls.enable = true;
        };
      };

      # Formatters
      conform-nvim = {
        enable = true;
        settings.formatters_by_ft = {
          python = [ "ruff_format" ];
          nix = [ "nixfmt" ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
          html = [ "prettier" ];
          css = [ "prettier" ];
          json = [ "prettier" ];
        };
      };

      # Pairs automatiques
      nvim-autopairs.enable = true;

      # Commentaires
      comment.enable = true;

      # Surround
      surround.enable = true;
    };

    extraPackages = with pkgs; [
      # Formatters
      nixfmt-rfc-style
      nodePackages.prettier
      ruff
      # LSP deps
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
    ];
  };

  # Yazi
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
      };
    };
    theme = {
      manager = {
        cwd = {
          fg = "#F5EDED";
        };
        hovered = {
          fg = "#F5EDED";
          bg = "#3E2020";
        };
        preview_hovered = {
          underline = true;
        };
        find_keyword = {
          fg = "#D72323";
          bold = true;
        };
        find_position = {
          fg = "#D72323";
          bg = "#0a0a0a";
        };
        marker_selected = {
          fg = "#D72323";
          bg = "#D72323";
        };
        tab_active = {
          fg = "#F5EDED";
          bg = "#3E2020";
        };
        tab_inactive = {
          fg = "#6e5a5a";
          bg = "#0a0a0a";
        };
        border_symbol = "│";
        border_style = {
          fg = "#3E3636";
        };
      };
      status = {
        separator_open = "";
        separator_close = "";
        separator_style = {
          fg = "#0a0a0a";
          bg = "#0a0a0a";
        };
        mode_normal = {
          fg = "#0a0a0a";
          bg = "#D72323";
          bold = true;
        };
        mode_select = {
          fg = "#0a0a0a";
          bg = "#a01818";
          bold = true;
        };
        mode_unset = {
          fg = "#0a0a0a";
          bg = "#3E3636";
          bold = true;
        };
        progress_label = {
          fg = "#F5EDED";
          bold = true;
        };
        progress_normal = {
          fg = "#D72323";
          bg = "#0a0a0a";
        };
        progress_error = {
          fg = "#ff3535";
          bg = "#0a0a0a";
        };
        permissions_t = {
          fg = "#6e5a5a";
        };
        permissions_r = {
          fg = "#F5EDED";
        };
        permissions_w = {
          fg = "#D72323";
        };
        permissions_x = {
          fg = "#c97a7a";
        };
        permissions_s = {
          fg = "#3E3636";
        };
      };
      input = {
        border = {
          fg = "#3E3636";
        };
        title = {
          fg = "#F5EDED";
        };
        value = {
          fg = "#F5EDED";
        };
        selected = {
          bg = "#3E2020";
        };
      };
      select = {
        border = {
          fg = "#3E3636";
        };
        active = {
          fg = "#D72323";
        };
        inactive = {
          fg = "#6e5a5a";
        };
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        userName = "Relka-Dev";
        userEmail = "relka.dev@gmail.com";
      };
    };
  };

  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;
    matchBlocks."github.com" = {
      identityFile = "~/.ssh/id_ed25519";
      user = "git";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "lambda";
      plugins = [
        "git"
        "sudo"
        "docker"
        "colored-man-pages"
        "command-not-found"
      ];
    };

    shellAliases = {
      ll = "ls -lah";
      la = "ls -A";
      l = "ls -CF";
      update = "sudo nixos-rebuild switch";
      test = "sudo nixos-rebuild test";
      rollback = "sudo nixos-rebuild switch --rollback";
      cleanup = "sudo nix-collect-garbage -d";
      generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      gd = "git diff";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      ports = "netstat -tulanp";
      myip = "curl ifconfig.me";
      dj = "python manage.py";
      djrun = "python manage.py runserver";
      djmig = "python manage.py migrate";
      djmake = "python manage.py makemigrations";
      grep = "grep --color=auto";
      fhere = "find . -name";
    };

    initContent = ''
      export EDITOR=nvim
    '';
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-python.vscode-pylance
        eamodio.gitlens
        bbenoist.nix
        jnoortheen.nix-ide
        pkief.material-icon-theme
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        ms-vscode-remote.remote-ssh
        github.github-vscode-theme
      ];

      userSettings = {
        "editor.fontSize" = 14;
        "editor.fontFamily" = "'JetBrains Mono', 'monospace'";
        "editor.tabSize" = 4;
        "editor.insertSpaces" = true;
        "editor.wordWrap" = "on";
        "editor.minimap.enabled" = true;
        "editor.formatOnSave" = true;
        "editor.bracketPairColorization.enabled" = true;
        "workbench.iconTheme" = "material-icon-theme";
        "terminal.integrated.fontFamily" = "JetBrains Mono";
        "terminal.integrated.fontSize" = 13;
        "files.autoSave" = "onFocusChange";
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
        "[python]" = {
          "editor.tabSize" = 4;
        };
        "git.enableSmartCommit" = true;
        "git.autofetch" = true;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "telemetry.telemetryLevel" = "off";
      };
    };
  };
}
