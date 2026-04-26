{ pkgs, ... }:

{
  home.packages = with pkgs; [
    asciinema # 终端会话录制工具
    asciinema-agg # asciinema 录制转 GIF 工具
  ];
}
