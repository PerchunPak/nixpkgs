{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zjstatus-hints";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "b0o";
    repo = "zjstatus-hints";
    tag = "v${finalAttrs.version}";
    hash = "sha256-4KceZNBUuc2+V6sER0c7eouP0KcMEqdKgSjaddSXhGY=";
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';
  cargoLock.lockFile = ./Cargo.lock;

  meta = {
    description = "Add key binding hints for zjstatus";
    homepage = "https://github.com/b0o/zjstatus-hints";
    changelog = "https://github.com/b0o/zjstatus-hints/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
