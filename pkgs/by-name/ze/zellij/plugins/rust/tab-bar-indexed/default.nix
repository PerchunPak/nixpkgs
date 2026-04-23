{
  lib,
  rustPlatform,
  fetchFromGitHub,

  _binary ? "tab-bar",
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-${_binary}-indexed";
  version = "0.44.3";

  src = fetchFromGitHub {
    owner = "ivoronin";
    repo = "zellij-tab-bar-indexed";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ha3UjorvrRJpo/9g6rUunjko8DHkRF97Gvoy8dUoxzs=";
  };

  postPatch = ''
    # https://github.com/ivoronin/zellij-tab-bar-indexed/pull/5
    ln -s ${./Cargo.lock} Cargo.lock
  '';
  cargoLock.lockFile = ./Cargo.lock;

  cargoBuildFlags = [ "--bin=${_binary}" ];

  meta = {
    description = "Tab-bar plugin for Zellij with tab indices";
    homepage = "https://github.com/ivoronin/zellij-tab-bar-indexed";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
