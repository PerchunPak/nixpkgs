{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
  versionCheckHook,
}:

buildGoModule (finalAttrs: {
  __structuredAttrs = true;

  pname = "cliproxyapi";
  version = "7.2.115";

  src = fetchFromGitHub {
    owner = "router-for-me";
    repo = "CLIProxyAPI";
    tag = "v${finalAttrs.version}";
    hash = "sha256-he72VXahbwW2GGV8lBcrg1qoY0/am7seMoz538WNeIE=";
  };

  vendorHash = "sha256-CrDp7MOr+AwJUhTovklXx3F1yaktQlvD7VYhYSY6VvY=";

  subPackages = [ "cmd/server" ];

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${finalAttrs.version}"
  ];

  postInstall = ''
    mv $out/bin/server $out/bin/cliproxyapi
  '';

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "--version";
  doInstallCheck = true;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Proxy that provides OpenAI/Gemini/Claude/Codex/Grok compatible API interfaces";
    homepage = "https://github.com/router-for-me/CLIProxyAPI";
    changelog = "https://github.com/router-for-me/CLIProxyAPI/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ anish ];
    mainProgram = "cliproxyapi";
  };
})
