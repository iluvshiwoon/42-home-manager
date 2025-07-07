{inputs, config, pkgs, ... }:

{
imports = [
./modules/nvim.nix
];

programs.neovim.nvimdots = {
enable = true;
mergeLazyLock = true;
};
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kgriset";
  home.homeDirectory = "/home/kgriset";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
inputs.zen-browser.packages.${pkgs.system}.default
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kgriset/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf"];
    };
    initExtraFirst = ''
      export PATH=~/.config/emacs/bin:$PATH
      DISABLE_MAGIC_FUNCTIONS=true
      export "MICRO_TRUECOLOR=1"
      eval "$(zoxide init --cmd cd zsh)"
    '';

    initExtra = ''
      flakify () {
        if [ -z "$1" ]; then
          echo "Error: Template name required"
          echo "Usage: nix-init-template <template-name>"
          return 1
        fi

        nix flake init --refresh -t "github:iluvshiwoon/dev-env#$1"
        direnv allow
        echo -e ".direnv\n.envrc" >> ./.gitignore
      }
    '';

    shellAliases = {
    };
  };

programs.ghostty = {
	enable = true;
	enableZshIntegration = true;
	settings = {
	theme = "GruvboxLight";
	#command = "${pkgs.zsh}/bin";
};
};
  programs.zoxide = {
  enable = true;
    enableZshIntegration = true;
  };
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      config.global.hide_env_diff = true;
    };
    # zsh.enable = true
  };
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = {
      right_format = "$cmd_duration";

      directory = {
        format = "[ ](bold #89b4fa)[ $path ]($style)";
        style = "bold #b4befe";
      };

      character = {
        success_symbol = "[ ](bold #89b4fa)[ ➜](bold green)";
        error_symbol = "[ ](bold #89b4fa)[ ➜](bold red)";
        # error_symbol = "[ ](bold #89dceb)[ ✗](bold red)";
      };

      cmd_duration = {
        format = "[]($style)[[󰔚 ](bg:#161821 fg:#d4c097 bold)$duration](bg:#161821 fg:#BBC3DF)[ ]($style)";
        disabled = false;
        style = "bg:none fg:#161821";
      };

      # directory.substitutions = {
      # "~" = "󰋞";
      # "Documents" = " ";
      # "Downloads" = " ";
      # "Music" = " ";
      # "Pictures" = " ";
      # };

      #      palette = "catppuccin_mocha";
    }; # // builtins.fromTOML (builtins.readFile "${inputs.catppuccin-starship}/palettes/mocha.toml");
  };
}
