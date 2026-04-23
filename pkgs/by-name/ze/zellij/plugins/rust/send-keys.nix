{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-send-keys";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "atani";
    repo = "zellij-send-keys";
    tag = "v${finalAttrs.version}";
    hash = "sha256-MtW1J/0O0f/RmGjAHNKkq7HzWheCWGJI06oMOqW/gJI=";
  };

  cargoHash = "sha256-2ocnBJdDZpPDoj6qqLehzIUM5DsZnH5ZmEkYSyVduTw=";

  meta = {
    description = "Send text/commands to specific panes from outside or other panes";
    homepage = "https://github.com/atani/zellij-send-keys";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
