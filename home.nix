{ config, pkgs, ... }:

{
  home-manager.users.yoav = {
    home.stateVersion = "25.05";      # match your NixOS release

    programs.bash.enable = true;

    programs.git = {
      enable = true;
      userName = "Yoav Ben-Yosef";
      userEmail = "yoav.benyosef@gmail.com";
    };

    home.packages = with pkgs; [
      neofetch
    ];

    # KDE/Plasma config files
    home.file.".config/plasma-org.kde.plasma.desktop-appletsrc".source = ./dotfiles/plasma-org.kde.plasma.desktop-appletsrc;
    home.file.".config/dolphinrc".source = ./dotfiles/dolphinrc;
    home.file.".config/powerdevilrc".source = ./dotfiles/powerdevilrc;

#     # KDE/Plasma Power management
#     home.file.".config/powerdevilrc".source = ./dotfiles/powerdevilrc;

    # KDE/Plasma Wayland keyboard layout (Alt+Shift switching)
    home.file.".config/kxkbrc".text = ''
      [Layout]
      Use=true
      LayoutList=us,il
      Options=grp:alt_shift_toggle
      ResetOldOptions=true
      DisplayNames=
      ShowFlag=true
      ShowLabel=false
      # SwitchingPolicy=Window
      SwitchMode=Window
    '';

    # KDE/Plasma Wayland keyboard repeat rate and delay
    home.file.".config/kcminputrc".text = ''
      [Keyboard]
      KeyboardRepeat=true
      RepeatDelay=300
      RepeatRate=30
    '';

  };
}
