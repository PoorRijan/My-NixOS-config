{pkgs, ...}:

{
    home.packages = with pkgs;
    let
      my_R_packages_list = with rPackages; [
        tidyverse
        rPackages.languageserver
        bslib
        ggplot2
        DT
        ggpubr
        shinyFiles
        bigsnpr
        ggExtra
        plotly
        shiny
        ape
        data_table
        ggtree
        devtools
        igraph
        dplyr
        argparse
        rPackages.IRkernel
        shinyBS
        reactlog
        rlang
        svglite
        phylotools
      ];
      
      RStudio-with-my-packages = rstudioWrapper.override{
        packages = my_R_packages_list;
      };
      R-with-my-packages = rWrapper.override{
        packages = my_R_packages_list;
      };
      python-with-my-packages = python3.withPackages (ps: with ps; [
        numpy
        pandas
        matplotlib
        spyder
        spyder-kernels
        python312Packages.psycopg2
        python312Packages.pyarrow
        python312Packages.marimo
        python312Packages.duckdb
        python312Packages.pysam
        python312Packages.ipykernel
        python312Packages.jupyterlab
        python312Packages.polars
        python312Packages.qtconsole
        python312Packages.newick
        python312Packages.ete3
        python312Packages.xlsx2csv
        python312Packages.flask
        python312Packages.sqlalchemy
        python312Packages.flask-sqlalchemy
        python312Packages.werkzeug
        python312Packages.flask-session
        python312Packages.pyqt6
      ]);
    in
     [
      anki-bin
      atuin
      authenticator
      autoconf269
      automake115x
      awscli2
      backblaze-b2
      bcftools
      beeper
      brave
      bzip2
      c2nim
      calibre
      canon-cups-ufr2
      cargo
      clementine
      comma
      duckdb
      emacs
      firefox
      fish
      flutter
      fzf
      gccgo13
      gdb
      ghostty
      gimp
      git
      glab
      glibc
      gnome-podcasts
      gnumake42
      helix
      htslib
      hugo
      inetutils
      inkscape
      jdk17
      jellyfin-ffmpeg
      joplin-desktop
      julia
      kbfs
      keybase
      kitty
      lazygit
      libgcc
      libreoffice
      logseq
      mailspring
      mercurial
      mosh
      ncurses
      neovim
      nim
      nimble
      nodePackages_latest.wrangler
      notcurses
      obs-studio
      onedriver
      openconnect
      pandoc
      perl
      plink-ng
      postgresql_16
      protonvpn-gui
      pyright
      python-with-my-packages
      R-with-my-packages
      rclone
      ripcord
      ripgrep
      RStudio-with-my-packages
      rustc
      samba4Full
      sioyek
      sox
      spotify
      spotube
      sqlite-interactive
      stow
      syncthing
      tangram
      tesseract4
      the-way
      thunderbird
      tree
      tor-browser
      typst
      unzip
      valgrind
      vcftools
      vlc
      vscode-fhs
      waydroid
      wget
      xclip
      xz
      yazi
      yt-dlp
      ytdownloader
      zed-editor
      zellij
      zig
      zlib
      zlib.dev
      zoom-us
      zotero
    ];

    programs.atuin = {
      enable = true;
      enableFishIntegration = true;
    };

    nixpkgs.config.permittedInsecurePackages = [
      "electron-27.3.11"
    ];
    # this should enable zsh as the default shell
    
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    home.stateVersion = "24.11";
};
