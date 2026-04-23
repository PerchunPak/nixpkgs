{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-new-tab-next-to-current";
  version = "0-unstable-2026-04-20";

  src = fetchFromGitHub {
    owner = "vimkim";
    repo = "zellij-new-tab-next-to-current";
    rev = "b37da77975ba5c3c42a5b1bec2fc2590faf33aaa";
    hash = "sha256-igtd8PXgB7e8HzM0w1PpJ0wh/ZH9gDM4Jg5EdKEedpw=";
  };

  cargoHash = "sha256-U6bNOx6TbggY6zq4emMfTE6ZCXM9czOAcaCpf/5Oqlg=";

  meta = {
    description = "Open a new tab next to the current tab";
    homepage = "https://github.com/vimkim/zellij-new-tab-next-to-current";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
