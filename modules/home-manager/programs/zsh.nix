{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history.size = 100000;
    history.path = "/home/mdlsvensson/.config/zsh/history";
    shellAliases = {
      # General
      fz = "fzf";
      cd = "z";
      vi = "nvim";
      ls = "eza -a";
      # Lazygit
      lg = "lazygit";
      lgnix = "lazygit -p ~/Repo/nixos-svensson";
      # SSH
      ssh-eval = ''eval "$(ssh-agent -s)"'';
    };
    zplug.enable = true;
    zplug.plugins = [
      { name = "zsh-users/zsh-autosuggestions"; }
      { name = "zsh-users/zsh-syntax-highlighting"; }
    ];
    initExtra = ''
      bindkey '^I'   complete-word
      bindkey '^[[Z' autosuggest-accept
    '';
    envExtra = ''
      function trash() {
        rm -rf ~/.local/share/Trash/*
      }

      function garbage() {
        sudo nix-collect-garbage --delete-older-than 10d
      }

      function garbage-all() {
        sudo nix-collect-garbage -d
      }

      function clone() {
        url="$1"

        if [ $# -eq 0 ]; then
          >&2 echo "No arguments provided"
          return 1
        fi

        gh repo clone $url
      }

      function flake() {
        command="$1"

        if [ $# -eq 0 ]; then
          >&2 echo "No arguments provided"
          return 1
        fi

        case "$command" in
          update)
            nix flake update /home/mdlsvensson/Repo/nixos-svensson
            ;;
          switch | build)
            cp /etc/nixos/hardware-configuration.nix ~/Repo/nixos-svensson/modules
            git -C ~/Repo/nixos-svensson/modules add hardware-configuration.nix

            sudo nixos-rebuild $command --flake ~/Repo/nixos-svensson/#svensson

            git -C ~/Repo/nixos-svensson/modules restore --staged hardware-configuration.nix
            rm ~/Repo/nixos-svensson/modules/hardware-configuration.nix
            ;;
          new)
            shift 1
            destination_path="."

            if [[ "$#" -gt 0 ]]; then
              destination_path="$1"
            fi

            nix flake new $destination_path
            ;;
          template)
            shift 1
            template_url=""
            destination_path="."

            if [[ "$#" -gt 0 ]]; then
              template_url="$1"
              shift 1
            fi

            if [[ "$#" -gt 0 ]]; then
              destination_path="$1"
            fi

            nix flake new $destination_path -t $template_url
            ;;
          allow)
            echo "use flake" >> .envrc && direnv allow
            ;;
          *)
            echo "Error: Unknown command '$command'"
            return 1
            ;;
        esac
      }

      function pkl() {
        if [ $# -eq 0 ]; then
          >&2 echo "No arguments provided"
          return 1
        fi

        command="$1"
        filename="$2"
        outputfilename="''${filename%.pkl}.json"

        case "$command" in
          eval)
            jpkl eval -f json -o "$outputfilename" "$filename"
            ;;
          *)
            echo "Error: Unknown command '$command'"
            return 1
            ;;
        esac
      }

      function dev() {
        nix develop -c zsh
      }
    '';
  };
}