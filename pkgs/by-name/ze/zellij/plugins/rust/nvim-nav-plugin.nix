{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-nvim-nav-plugin";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "sharph";
    repo = "zellij-nvim-nav-plugin";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Li4gn3XNuvnx0gLvczB4JHwL0D7smhvm+3ObmPP5r08=";
  };

  cargoHash = "sha256-N1lO0d5ASyxraB+aiYMMMGqDUVAoQHg8nYLPcfCr6oE=";

  meta = {
    description = "Plugin for Zellij to run alongside zellij-nav.nvim";
    homepage = "https://github.com/sharph/zellij-nvim-nav-plugin";
    changelog = "https://github.com/sharph/zellij-nvim-nav-plugin/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
