{
  description = "A flake to run Mikhmon on NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        php = pkgs.php82.buildEnv {
          extensions = ({ enabled, all }: enabled ++ [ all.session all.gd all.curl all.mbstring all.zlib ]);
          extraConfig = ''
            memory_limit = 256M
            post_max_size = 64M
            upload_max_filesize = 64M
            session.save_path = "/home/azam/mikhmon/sessions"
          '';
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            php
          ];

          shellHook = ''
            echo "Mikhmon development environment loaded!"
            echo "Run ./run.sh to start the server."
          '';
        };
      }
    );
}
