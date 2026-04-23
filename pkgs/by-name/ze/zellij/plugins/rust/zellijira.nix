{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellijira";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "dam4rus";
    repo = "zellijira";
    tag = "v${finalAttrs.version}";
    hash = "sha256-hlmesV2k5LahOtF9/ZDlkNQ/aiOR2vZL14+9+rIQ3M4=";
  };

  cargoHash = "sha256-+SL6UffE+IgPwSgfgLRZMh1R5+DzdoqnlG98Hw0Nmk4=";

  meta = {
    description = "Zellij plugin for managing sessions via Jira";
    homepage = "https://github.com/dam4rus/zellijira";
    changelog = "https://github.com/dam4rus/zellijira/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
