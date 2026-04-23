{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkgsBuildBuild,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-history-selector";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "longhongc";
    repo = "zellij-history-selector";
    tag = "v${finalAttrs.version}";
    hash = "sha256-SfgsKevR/4RLyN/B9YYQ/PiEXB8fZZZy79Jjosv0M5A=";
  };

  cargoHash = "sha256-5QGfzSJeN2S1XielxaGwlFT3Nb3FqV55F2xewAPyICA=";

  passthru.runtimeDeps = [
    pkgsBuildBuild.python3
  ];

  meta = {
    description = "Search shell, REPL, clipboard, or custom history sources with preview and insert-back";
    homepage = "https://github.com/longhongc/zellij-history-selector";
    changelog = "https://github.com/longhongc/zellij-history-selector/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
