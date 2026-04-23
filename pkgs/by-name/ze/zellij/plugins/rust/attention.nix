{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-attention";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "KiryuuLight";
    repo = "zellij-attention";
    tag = "v${finalAttrs.version}";
    hash = "sha256-T36mzLbXCUqBeLa5hUX4/gMZ/c41szKAcLrsyXB6TIQ=";
  };

  cargoHash = "sha256-kXBfhSrb0UQ6tmM7I9tmQOii1JPCYOS9rcRbse0i89Q=";

  meta = {
    description = "Add notification icons to tab names when panes need attention";
    homepage = "https://github.com/KiryuuLight/zellij-attention";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
