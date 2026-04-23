{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zellij-what-time";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "pirafrank";
    repo = "zellij-what-time";
    tag = finalAttrs.version;
    hash = "sha256-6+uNUC22RL6jbe5lqQH3Bvp8XkzNBwVbNzlt+lBQ7Ys=";
  };

  cargoHash = "sha256-xexFoxcpHHEEvD6K91ZJ7UzLyP7R2o6lXzG2TvwIV7Y=";

  meta = {
    description = "Show host system date and/or time in the status bar";
    homepage = "https://github.com/pirafrank/zellij-what-time";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ PerchunPak ];
  };
})
