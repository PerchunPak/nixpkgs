{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-pane-picker";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "shihanng";
    repo = "zellij-pane-picker";
    tag = "v${finalAttrs.version}";
    hash = "sha256-v9oLovSPzld9v9yG2mAmD8ex07xVVWmACb9y1txRXIs=";
  };

  cargoHash = "sha256-WFafx4WEWVnHW6vp5PjabYJmOMrvyivLQhGrn6B5IB0=";

  meta = {
    description = "Quickly switch, star, and jump to panes with customizable keyboard shortcuts";
    homepage = "https://github.com/shihanng/zellij-pane-picker";
    changelog = "https://github.com/shihanng/zellij-pane-picker/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
