{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    preservation.url = "github:nix-community/preservation";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      isHost = name: type: type == "directory" && builtins.pathExists ./hosts/${name}/default.nix;
    in
    {
      nixosConfigurations = lib.mapAttrs
        (name: _: lib.nixosSystem { modules = [ ./hosts/${name} ]; specialArgs = { inherit inputs; }; })
        (lib.filterAttrs isHost (builtins.readDir ./hosts));
    };
}
