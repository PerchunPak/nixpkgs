{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-getmode";
  version = "0-unstable-2026-02-28";

  src = fetchFromGitHub {
    owner = "chardskarth";
    repo = "zellij-getmode";
    rev = "e9b0a90eb184ffa1c450ab278915e5de0c4bab05";
    hash = "sha256-HsqIfwNRI6P2cG0lkmMUG4519PA/9LzRpvREUftTUdY=";
  };

  cargoHash = "sha256-7rGqxI1OzGN1JjEchOv7IULC+WqRnNRudeyFXXJRP6w=";

  meta = {
    description = "Simple utility plugin that gets the current input mode of Zellij";
    homepage = "https://github.com/chardskarth/zellij-getmode";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
