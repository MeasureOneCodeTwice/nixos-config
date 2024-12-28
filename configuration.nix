# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Winnipeg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.logan = {
    isNormalUser = true;
    description = "Logan Decock";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    #terminal applications 
    tmux
    openssh
    github-cli
    git

    #graphical applications
    firefox
    thunderbird
    
    #desktop environment specific packages
    wl-clipboard
    cliphist
    fuzzel
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #nvim config
  #Use the Nix package search engine to find
  #even more plugins : https://search.nixos.org/packages
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    configure = {
      customRC = ''

        set showmatch               " show matching 
        set ignorecase              " case insensitive 
        set mouse=v                 " middle-click paste with 
        set hlsearch                " highlight search 
        set incsearch               " incremental search
        set tabstop=4               " number of columns occupied by a tab 
        set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
        set expandtab               " converts tabs to white space
        set shiftwidth=4            " width for autoindents
        set autoindent              " indent a new line the same amount as the line just typed
        set nu rnu                  " add hybrid line numbers
        set wildmode=longest,list   " get bash-like tab completions
        set mouse=a                 " enable mouse click
        set ttyfast                 " Speed up scrolling in Vim
        set formatoptions-=c formatoptions-=r formatoptions-=o     " disable auto insertion of comments
        set number
        set relativenumber
        
        colorscheme molokayo    "colorscheme
        highlight Comment cterm = italic ctermfg=Gray   "changes comment colour
        highlight Conceal ctermfg = darkGray    "sets conceal group (tab indicatior) color to gray
        let g:indentLine = '▏'  "sets the tab display character
        
        " set spell                 " enable spell check (may need to download language package)
        " set spell                 " enable spell check (may need to download language package)

      '';
      packages.packages = with pkgs.vimPlugins; {
        #loaded on launch
	start = [ 
          vim-surround
          awesome-vim-colorschemes
          vim-vinegar
          vim-commentary
	];
      };
    };
  };
  
  programs.foot = {
    enable = true;
    # needed?
    # enableBashIntegration = true

    settings = {

      main = {
        font="monospace:size=18";
      };

      colors = {
        background="000000";
        alpha=0.85;
      };

    };

  };

  #sway window manager config
  programs.sway = {
  	enable = true;
	wrapperFeatures.gtk = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
