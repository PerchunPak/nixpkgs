{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkgsBuildBuild,
}:
let
  pname = "zellij-playbooks";
  version = "0.1.0";
  sourceArgs = {
    owner = "yaroslavborbat";
    repo = "zellij-playbooks";
    tag = "v${version}";
    hash = "sha256-PCaglLZ+RTjPKcmGuCM+wcj7nXQ47SfhAlmlz5VVKtc=";
  };
  meta = {
    description = "Browse, select, and execute commands from playbook files directly in the terminal";
    homepage = "https://github.com/yaroslavborbat/zellij-playbooks";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
in
rustPlatform.buildRustPackage (finalAttrs: {
  inherit pname version meta;
  src = fetchFromGitHub sourceArgs;

  cargoHash = "sha256-gqZz5RTl9xtutb865FNoIrSecCsDnovbX+IsiLPIV3o=";

  passthru.vimPlugin = pkgsBuildBuild.callPackage (
    { vimUtils, fetchFromGitHub }:
    vimUtils.buildVimPlugin {
      inherit pname version meta;
      src = fetchFromGitHub sourceArgs;
      sourceRoot = "source/vim-plugin";
    }
  ) { };
})
