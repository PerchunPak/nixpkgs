{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkgsBuildBuild,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zsm";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "liam-mackie";
    repo = "zsm";
    tag = "v${finalAttrs.version}";
    hash = "sha256-+W3l86MkqhklHLQbS9ODu6R4BqSKINyHCdjjO4nIBt0=";
  };

  cargoHash = "sha256-SxvEjYRzxgF6dCQb25TCkl8XHnKc8CI1TCSgVjoSXWg=";

  passthru.runtimeDeps = [ pkgsBuildBuild.zoxide ];

  meta = {
    description = "Integrate zoxide (smart directory navigation) with Zellij sessions";
    homepage = "https://github.com/liam-mackie/zsm";
    changelog = "https://github.com/liam-mackie/zsm/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
