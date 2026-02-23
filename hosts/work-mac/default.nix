{ pkgs, rust-overlay, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/homebrew.nix
    ../../modules/home.nix
    ../../modules/host-guard.nix
  ];

  networking.hostName = "work-mac";
  nixpkgs.overlays = [ rust-overlay.overlays.default ];
}
