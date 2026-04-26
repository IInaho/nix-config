{ pkgs, ... }:

{
  home.packages = with pkgs; [
    isd
    kmon
  ];
}
