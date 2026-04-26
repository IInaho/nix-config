{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc # GNU C/C++ 编译器
    gnumake # GNU 构建工具
    nodejs # Node.js 运行时
    python3 # Python 3 运行时
    python3Packages.pip # Python 包管理器
    go # Go 语言编译器与运行时
    tree-sitter # 语法解析器生成器
  ];
}
