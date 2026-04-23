{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkgsBuildBuild,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-worktree";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "sharph";
    repo = "zellij-worktree";
    tag = "v${finalAttrs.version}";
    hash = "sha256-5efD2F2UMRfYM4st2+mfsmUwqELXtnxAlBqi1vmBNKk=";
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';
  cargoLock.lockFile = ./Cargo.lock;

  passthru.runtimeDeps = [
    pkgsBuildBuild.git
  ];

  meta = {
    description = "Manage git worktrees";
    homepage = "https://github.com/sharph/zellij-worktree";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
