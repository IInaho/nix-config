{ pkgs, ... }:

{
  # 为没有图标的应用程序添加默认图标
  # 放在 ~/.local/share/applications/ 让 fuzzel 能找到
  home.file.".local/share/applications/yazi.desktop".source = pkgs.writeTextFile {
    name = "yazi.desktop";
    text = ''
      [Desktop Entry]
      Name=Yazi
      GenericName=Terminal File Manager
      Comment=Blazing fast file manager written in Rust
      Exec=yazi %u
      Terminal=true
      Type=Application
      Icon=utilities-terminal
      Categories=System;FileTools;FileManager;TerminalEmulator;
      Keywords=file;manager;browser;terminal;
    '';
  };

  home.file.".local/share/applications/xterm.desktop".source = pkgs.writeTextFile {
    name = "xterm.desktop";
    text = ''
      [Desktop Entry]
      Name=XTerm
      Comment=Terminal emulator for X
      Exec=xterm
      Terminal=false
      Type=Application
      Icon=utilities-terminal
      Categories=System;TerminalEmulator;
    '';
  };

  home.file.".local/share/applications/kbd-layout-viewer5.desktop".source = pkgs.writeTextFile {
    name = "kbd-layout-viewer5.desktop";
    text = ''
      [Desktop Entry]
      Name=Keyboard layout viewer
      GenericName=Keyboard Layout Tester
      Comment=View keyboard layout
      Exec=kbd-layout-viewer5
      Icon=preferences-desktop-keyboard
      Terminal=false
      Type=Application
      Categories=Qt;KDE;Utility;
    '';
  };
}
