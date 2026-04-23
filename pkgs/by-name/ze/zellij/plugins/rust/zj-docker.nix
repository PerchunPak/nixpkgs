{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zj-docker";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "dj95";
    repo = "zj-docker";
    tag = "v${finalAttrs.version}";
    hash = "sha256-xuypRhYDXAvYgvCusxa+ut8ITIuZxYkUa3fdu1eLSdA=";
  };

  cargoHash = "sha256-xqm+qKEIg+agrqx+5OtEnHotwCcDMCoJ2f33syfBKek=";

  # NOTE: this actually depends on docker CLI, but user may want to use podman
  # instead, so not specifying it here

  meta = {
    description = "Display docker containers and perform basic operations on them";
    homepage = "https://github.com/dj95/zj-docker";
    changelog = "https://github.com/dj95/zj-docker/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
