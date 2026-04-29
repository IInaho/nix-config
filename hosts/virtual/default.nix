# 所有 VM 的 nixosConfigurations 定义
# 在 flake.nix 中通过 import 引入
{ nixpkgs, ... }:
{
  vm-k3s = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ./k3s.nix ];
  };
}
