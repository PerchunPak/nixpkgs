{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-workspace";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "vdbulcke";
    repo = "zellij-workspace";
    tag = "v${finalAttrs.version}";
    hash = "sha256-RrAL33fynBXpPEMkbNcRlG0UwofYJLN6MKiEkrJEztM=";
  };

  cargoHash = "sha256-n8pmiZP2+XQEkZNiHOLHjw46drI15K/HseR2MgFmxL4=";

  meta = {
    description = "Apply layouts to current Zellij session";
    homepage = "https://github.com/vdbulcke/zellij-workspace";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
