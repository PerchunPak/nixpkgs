{
  lib,
  stdenv,
  bash,
  fetchFromGitHub,
  nix-update-script,
  installShellFiles,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "nvm";
  version = "0.40.5";

  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "nvm-sh";
    repo = "nvm";
    tag = "v${finalAttrs.version}";
    hash = "sha256-R7gcqpYAgT96q4ckyvAbyi0wMiJaduSbE0j5HWXEUnM=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ installShellFiles ];

  buildPhase = ''
    runHook preBuild

    mkdir -p $out/bin
    cp nvm.sh $out/bin/nvm
    cp nvm-exec $out/bin/nvm-exec

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    installShellCompletion --bash --name nvm.sh bash_completion
    installShellCompletion --zsh --name _nvm bash_completion

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Node Version Manager - bash script to manage multiple Node.js versions";
    homepage = "https://github.com/nvm-sh/nvm";
    changelog = "https://github.com/nvm-sh/nvm/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
    mainProgram = "nvm";
    inherit (bash.meta) platforms;
  };
})
