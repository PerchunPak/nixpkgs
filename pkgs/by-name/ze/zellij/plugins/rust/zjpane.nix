{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zjpane";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "FuriouZz";
    repo = "zjpane";
    tag = "v${finalAttrs.version}";
    hash = "sha256-PnlXqyCWf9iK+jutnOkn0ZbvqVFrH0kBjc4IqL1J1Io=";
  };

  cargoHash = "sha256-OwYZZDa7d8I54uACADhMkhXr0oGFh4AsOhGU2neSU/I=";

  meta = {
    description = "Navigate between your panes and configure commands to execute easily";
    homepage = "https://github.com/FuriouZz/zjpane";
    changelog = "https://github.com/FuriouZz/zjpane/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
