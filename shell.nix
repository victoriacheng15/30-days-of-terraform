{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.opentofu
  ];

  shellHook = ''
    echo "Welcome to the 30 Days of OpenTofu development environment!"
    tofu --version
  '';
}
