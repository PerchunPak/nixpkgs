{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,

  # build-system
  setuptools,

  # dependencies
  aiohttp,
  attrs,
  frozendict,
  inject,
  loguru,
  nbdb,
  nix-prefetch-git,
  nurl,
  platformdirs,
  typer,

  # tests
  pytestCheckHook,
  aioresponses,
  pytest-asyncio,
  pytest-cov,
  pytest-mock,
}:
buildPythonPackage rec {
  pname = "nixpkgs-updaters-library";
  version = "0.1.0";
  pyproject = true;

  disabled = pythonOlder "3.12";

  src = fetchFromGitHub {
    owner = "PerchunPak";
    repo = "nixpkgs-updaters-library";
    tag = "v${version}";
    hash = "sha256-/hCtWTVasjWUSJzsBxbWNuBPGzaT0r8ukWL5g3G2q3Q=";
  };

  build-system = [ setuptools ];

  dependencies = [
    aiohttp
    attrs
    frozendict
    inject
    loguru
    nbdb
    nix-prefetch-git
    nurl
    platformdirs
    typer
  ];

  nativeCheckInputs = [
    pytestCheckHook

    aioresponses
    pytest-asyncio
    pytest-cov
    pytest-mock
  ];

  meta = {
    description = "Boilerplate-less updater library for Nixpkgs ecosystems";
    homepage = "https://github.com/PerchunPak/nixpkgs-updaters-library";
    changelog = "https://github.com/PerchunPak/nixpkgs-updaters-library/blob/v${version}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ perchun ];
  };
}
