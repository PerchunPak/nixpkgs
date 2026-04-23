{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zjswitcher";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "WingsZeng";
    repo = "zjswitcher";
    tag = "v${finalAttrs.version}";
    hash = "sha256-lACbFz3GP4E2kArdjTjpLdd1GpG9s7fo6mR0ltVO9Og=";
  };

  cargoHash = "sha256-D0dzibiVziWzKOOFnh6tNvOgxilyZqxSS71d9Yl3fa4=";

  meta = {
    description = "Automatically switch between normal mode and locked mode";
    homepage = "https://github.com/WingsZeng/zjswitcher";
    changelog = "https://github.com/WingsZeng/zjswitcher/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.unfree; # no license; unmaintained, so won't bother opening an issue
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
