{
  description = "Flake for Home-manager and shi";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Latest stable release of nixpkgs
    nixpkgs-stable.url = "nixpkgs/nixos-26.05";

    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixos-06cb-009a-fingerprint-sensor,
    ...
  } @ inputs:
  let
    system = "x86_64-linux";

    unstablePkgs = nixpkgs.legacyPackages.${system};
    stablePkgs = nixpkgs-stable.legacyPackages.${system};

    machines = {
      lithium = {
        branch = "unstable";
        mainUser = "miles";
        nixosConfig = ./hosts/lithium/configuration.nix;
        extraNixosModules = [ ];
      };
    };

    pkgsFor = machine:
      if machine.branch == "stable"
      then stablePkgs
      else unstablePkgs;

    nixpkgsFor = machine:
      if machine.branch == "stable"
      then nixpkgs-stable
      else nixpkgs;

  in {
    packages.${system}.default =
      unstablePkgs.writeShellScriptBin "setup"
        (builtins.readFile ./setup.sh);

    nixosConfigurations =
      builtins.mapAttrs
        (machineName: machine:
          (nixpkgsFor machine).lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit inputs system stablePkgs unstablePkgs;
              hostname = machineName;
              mainUser = machine.mainUser;
              fingerprintSensor = nixos-06cb-009a-fingerprint-sensor;
            };

            modules =
              [ machine.nixosConfig ]
              ++ machine.extraNixosModules;
          })
        machines;
  };
}
