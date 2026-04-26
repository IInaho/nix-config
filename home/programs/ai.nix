{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
    opencode
    mcp-nixos
  ];
}
