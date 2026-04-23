{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-qr-share";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "dbachelder";
    repo = "zellij-qr-share";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ecBIdzGE0E1IoizYQUvaNByRO9FMIS8BVtI4eUl0lF4=";
  };

  cargoHash = "sha256-qEBGJWIvB5oMoaBAqUwePigBiC/sp22aidX24FkERxg=";

  meta = {
    description = "Show QR codes for web tokens";
    homepage = "https://github.com/dbachelder/zellij-qr-share";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
