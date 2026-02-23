{ pkgs, ... }:
{
  users.users.jeff = {
    name = "jeff";
    home = "/Users/jeff";
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.jeff = { pkgs, ... }: {
      home.stateVersion = "24.11";

      home.packages = with pkgs; [
        # core
        git
        fish
        starship
        tmux
        bat
        eza
        fd
        ripgrep
        fzf
        du-dust
        tokei
        cloc
        tldr
        yazi
        ranger
        lazygit
        delta
        gh

        # kubernetes
        kubectl
        k9s
        helm
        crane
        kind
        sops
        age

        # languages
        go
        lua-language-server
        python3
        uv
        fnm

        # rust via overlay
        (rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" ];
        })

        # infra
        cloudflared
        tailscale
        mosh
        nmap

        # build
        cmake
        gnumake
        stow

        # other
        btop
        fastfetch
        pandoc
        watch
        pv
        imagemagick
        jq
        yq-go
        tree
        curl
        wget

        # cargo tools (available in nixpkgs)
        bob-nvim
        zoxide
        mprocs
      ];

      home.file = {
        ".config/fish" = {
          source = ../fish/.config/fish;
          recursive = true;
        };

        ".config/nvim" = {
          source = ../nvim/.config/nvim;
          recursive = true;
        };

        ".config/ghostty" = {
          source = ../ghostty/.config/ghostty;
          recursive = true;
        };

        ".config/starship.toml".source = ../starship/.config/starship.toml;

        ".tmux.conf".source = ../tmux/.tmux.conf;

        ".gitconfig".source = ../git/.gitconfig;

        ".config/lazygit" = {
          source = ../lazygit/.config/lazygit;
          recursive = true;
        };

        ".config/btop" = {
          source = ../btop/.config/btop;
          recursive = true;
        };
      };

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          if command -v fnm >/dev/null
            fnm env --use-on-cd --shell fish | source
          end

          if command -v zoxide >/dev/null
            zoxide init fish | source
          end
        '';
      };
    };
  };
}
