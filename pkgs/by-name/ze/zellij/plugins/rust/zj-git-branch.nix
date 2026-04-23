{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkgsBuildBuild,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zj-git-branch";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "dam4rus";
    repo = "zj-git-branch";
    tag = "v${finalAttrs.version}";
    hash = "sha256-sJObZe3JfWaqgdlXh/t8o7H0/AbQMVyfLVwIkE4jy0k=";
  };

  cargoHash = "sha256-M/WRDJDkZTF5/DIPoOTQIb4JJ2JNeZsh/FtRnHOY8TA=";

  passthru.runtimeDeps = [ pkgsBuildBuild.git ];

  meta = {
    description = "Manage git branches";
    homepage = "https://github.com/dam4rus/zj-git-branch";
    changelog = "https://github.com/dam4rus/zj-git-branch/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
