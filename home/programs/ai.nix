{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code # Claude AI 命令行工具
    opencode # 终端 AI 编码助手
    mcp-nixos # NixOS MCP 服务器
  ];
}
