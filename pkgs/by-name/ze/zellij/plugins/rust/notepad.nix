{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-notepad";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "0xble";
    repo = "zellij-notepad";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ZMISRi4NtNygT27m4DOhJg8xv7V1yRcbT4ZAuhHI194=";
  };

  cargoHash = "sha256-3S61D9EMzKORiX6mWeQYvAgxYtnCep+R5XdtLCTOP+c=";

  meta = {
    description = "Spawn a floating notepad pane using your $EDITOR";
    homepage = "https://github.com/0xble/zellij-notepad";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
