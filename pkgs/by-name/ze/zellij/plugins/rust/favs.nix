{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-favs";
  version = "1.0.5";

  src = fetchFromGitHub {
    owner = "JoseMM2002";
    repo = "zellij-favs";
    tag = "v${finalAttrs.version}";
    hash = "sha256-t+c8H301R8xlpB8EXnkZsRsFZqPHUcfG3wmVIFsAWtE=";
  };

  cargoHash = "sha256-UK6fGSHs/OT8qvCtVh1nzd4bMvs5Ax71C2A0RSq9QYo=";

  meta = {
    description = "Easily organize and switch between sessions with ease";
    homepage = "https://github.com/JoseMM2002/zellij-favs";
    changelog = "https://github.com/JoseMM2002/zellij-favs/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
