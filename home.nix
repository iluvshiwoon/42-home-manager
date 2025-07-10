{inputs, config, pkgs, ... }:

{
imports = [
./modules/nvim.nix
./modules/ghostty.nix
./modules/starship.nix
];


programs.neovim.nvimdots = {
enable = true;
mergeLazyLock = true;
};
  home.username = "kgriset";
  home.homeDirectory = "/home/kgriset";
  home.stateVersion = "25.05";

  home.packages = [
	  inputs.zen-browser.packages.${pkgs.system}.default
	  pkgs.nix-prefetch-git
  ];

  home.file = {
  };

home.sessionVariables = {
};

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
}
