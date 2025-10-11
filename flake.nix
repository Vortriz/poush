{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
        systems.url = "github:nix-systems/default";
        flake-utils = {
            url = "github:numtide/flake-utils";
            inputs.systems.follows = "systems";
        };
        treefmt-nix = {
            url = "github:numtide/treefmt-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        pre-commit-hooks = {
            url = "github:cachix/git-hooks.nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        flake-utils,
        treefmt-nix,
        pre-commit-hooks,
        ...
    }:
        flake-utils.lib.eachDefaultSystem (system: let
            pkgs = import nixpkgs {inherit system;};
            treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        in {
            formatter = treefmtEval.config.build.wrapper;

            checks = {
                pre-commit-check = pre-commit-hooks.lib.${system}.run {
                    src = ./.;
                    hooks = {
                        flake-checker = {
                            enable = true;
                            after = ["treefmt-nix"];
                        };
                        treefmt = {
                            enable = true;
                            package = self.formatter.${system};
                        };
                    };
                };
            };

            devShells.default = pkgs.mkShell {
                inherit (self.checks.${system}.pre-commit-check) shellHook;

                buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;

                packages = [pkgs.typst];
            };
        });
}
