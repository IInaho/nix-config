{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 14;
      cursor_shape = "beam";
    };
    keybindings = {
      # 标签页操作
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+q" = "quit";
      "ctrl+tab" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";
      "ctrl+shift+[" = "previous_tab";
      "ctrl+shift+]" = "next_tab";

      # 窗口操作
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+f" = "new_window_with_cwd";

      # 复制粘贴
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";

      # 窗口调整
      "ctrl+shift+up" = "resize_window taller";
      "ctrl+shift+down" = "resize_window shorter";
      "ctrl+shift+left" = "resize_window narrower";
      "ctrl+shift+right" = "resize_window wider";

      # 布局
      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+f11" = "toggle_fullscreen";

      # 滚动
      "ctrl+shift+page_up" = "scroll_line_up";
      "ctrl+shift+page_down" = "scroll_line_down";
      "ctrl+shift+home" = "scroll_to_top";
      "ctrl+shift+end" = "scroll_to_bottom";

      # 字体
      "ctrl+shift+z" = "zoom_font";
      "ctrl+shift+=" = "zoom_font_in";
      "ctrl+shift+-" = "zoom_font_out";
      "ctrl+shift+0" = "reset_font_size";

      # 其他
      "ctrl+shift+f2" = "show_kitty_env";
      "ctrl+shift+escape" = "clear_terminal reset active";
    };
  };
}