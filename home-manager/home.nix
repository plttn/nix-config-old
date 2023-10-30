# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      inputs.atuin-upstream.overlays.default
      # outputs.overlays.modifications.atuin

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "jack";
    homeDirectory = "/Users/jack";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  programs.zoxide.enable = true;
  programs.fish.enable = true;
  home.packages = with pkgs; [
    doggo
    bat
    nixpkgs-fmt
    asciinema
    gh
    nil
    nano
    nixpkgs-fmt
    unstable.eza
    just
    openssh
    rustup
    fzf
    _1password
    ngrok
    dnscontrol
    vhs
    ttyd
    ffmpeg
    atuin # double specified so overlay kicks in
    # gnupg
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
    fish_greeting = "";
  };

  xdg = {
    enable = true;
    configFile."fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";
  };


  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.wezterm.enable = true;

  programs.man.generateCaches = true;

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      filter_mode_shell_up_key_binding = "session";
      filter_mode = "host";
      show_preview = true;
      workspaces = true;
      # control_n_shortcuts = true;
      enter_accept = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
