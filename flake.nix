{
  description = "lznauy's NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    claude-code.url = "github:sadjow/claude-code-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quien = {
      url = "github:retlehs/quien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      noctalia,
      claude-code,
      agenix,
      quien,
      stylix,
      ...
    }@inputs:
    {
      # 主系统（当前 VMware 桌面机）
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

        modules = [
          agenix.nixosModules.default
          (
            { ... }:
            {
              nixpkgs.hostPlatform = "x86_64-linux";
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [
                claude-code.overlays.default
                inputs.nur.overlays.default
                (final: prev: {
                  quien = quien.packages.${prev.stdenv.hostPlatform.system}.default;
                  wayscrollshot = final.callPackage ./pkgs/wayscrollshot.nix { };
                })
              ];
            }
          )
          ./hosts/default/hardware.nix
          ./hosts/default/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.sharedModules = [
              inputs.nixvim.homeModules.nixvim
              inputs.noctalia.homeModules.default
              inputs.stylix.homeModules.stylix
            ];

            home-manager.users.lznauy = import ./home/default.nix;
          }
        ];
        specialArgs = { inherit inputs; };
      };

      devShells.x86_64-linux = import ./home/programs/devshell/default.nix { pkgs = nixpkgs.legacyPackages.x86_64-linux; };

    }
    // (import ./hosts/virtual/default.nix { inherit nixpkgs; });
}
