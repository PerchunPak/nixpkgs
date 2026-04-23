{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-jump-list";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "blank2121";
    repo = "zellij-jump-list";
    tag = "Latest"; # why?
    hash = "sha256-pMOhy3qHfRUhJxLQXElVD3XF/EKht0up7c70Ces8Jew=";
  };

  cargoHash = "sha256-8gOSqznqEOHNlZhvsQA3v5lPGZHRSF4WSht2aeafRV0=";

  meta = {
    description = "Add jump list for different navigation like in Vim, Neovim, or Emacs";
    homepage = "https://github.com/blank2121/zellij-jump-list";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
