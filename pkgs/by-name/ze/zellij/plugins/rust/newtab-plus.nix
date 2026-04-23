{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkgsBuildBuild,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-newtab-plus";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "AlexZasorin";
    repo = "zellij-newtab-plus";
    tag = "v${finalAttrs.version}";
    hash = "sha256-9Vr5TuuQydeAk831yxjoxN3MXlRpCkIhfkHL8TWrKqQ=";
  };

  cargoHash = "sha256-1OlCxaEoKNhsVKmyZ76BwJOe22qKuAgDlU0vPHsZANw=";

  passthru.runtimeDeps = [ pkgsBuildBuild.zoxide ];

  meta = {
    description = "Quickly name a new tab when creating it and set it's directory using zoxide";
    homepage = "https://github.com/AlexZasorin/zellij-newtab-plus";
    changelog = "https://github.com/AlexZasorin/zellij-newtab-plus/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
