{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  # additions = final: _prev: import ../pkgs {pkgs = final;};

  # This is an example of overriding attributes. We don't need to do this
  # once it is upstreamed in nixpkgs. It's already merged to 'master' we just
  # need to wait for a merge to 'nixos-unstable'
  wf-recorder = final: prev: {
    wf-recorder = prev.wf-recorder.overrideAttrs {
      patches = [
        # compile fixes from upstream, remove when they stop applying
        (final.fetchpatch {
          url =
            "https://github.com/ammen99/wf-recorder/commit/560bb92d3ddaeb31d7af77d22d01b0050b45bebe.diff";
          sha256 = "sha256-7jbX5k8dh4dWfolMkZXiERuM72zVrkarsamXnd+1YoI=";
        })
      ];
    };
  };

  zjstatus = final: prev: {
    zjstatus = inputs.zjstatus.packages.${prev.system}.default;
  };

  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
      # config.allowUnfreePredicate = pkg:
      #   builtins.elem (inputs.nixpkgs-stable.lib.getName pkg)
      #   allowed-unfree-packages;
    };
  };
}
