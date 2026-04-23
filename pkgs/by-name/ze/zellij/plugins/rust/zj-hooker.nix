{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zj-hooker";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "olekspickle";
    repo = "zj-hooker";
    tag = "v${finalAttrs.version}";
    hash = "sha256-dmjfQNsU65MEScdol4aIeTVpXhSC3IID4HnBMsRDaGA=";
  };

  cargoHash = "sha256-E5qo9wx/pvVQW9t2zQ+lsK3rFA09g4xQC4A4aSGKagQ=";

  meta = {
    description = "Run commands on session attach and detach";
    homepage = "https://github.com/olekspickle/zj-hooker";
    license = lib.licenses.unfree; # https://github.com/olekspickle/zj-hooker/pull/9
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
