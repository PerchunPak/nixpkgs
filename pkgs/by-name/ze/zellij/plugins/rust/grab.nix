{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "grab";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "imsnif";
    repo = "grab";
    tag = "v${finalAttrs.version}";
    hash = "sha256-K4gqEyVhG4Yujgo3ZwVHhv0vG6mCp9XN3npP6VRDXqI=";
  };

  cargoHash = "sha256-yiMIUdjynqX/gP/OuUEab7qYNkhnQdCH57JIxVtG0NI=";

  meta = {
    description = "Fuzzy finder for Rust devs";
    homepage = "https://github.com/imsnif/grab";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
