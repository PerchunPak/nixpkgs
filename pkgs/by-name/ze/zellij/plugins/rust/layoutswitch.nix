{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-layoutswitch";
  version = "0-unstable-2026-02-24";

  src = fetchFromGitHub {
    owner = "sgtrusty";
    repo = "zellij-layoutswitch";
    rev = "bc1c9de36b64c13379efa5609588788db69982c9";
    hash = "sha256-J8k/kGG4mFOfrGJ5VZV/pZmzPX2Tzk9ZQrJ/PqEmruw=";
  };

  cargoHash = "sha256-taBiW5zYPeNx+sexsya028FMquoFAFbU+3TewAWt7Tw=";

  meta = {
    description = "Switch between zellij layouts / panes for procedural configurations";
    homepage = "https://github.com/sgtrusty/zellij-layoutswitch";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
