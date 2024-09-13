{
  lib,
  stdenv,
  bison,
  blas,
  cairo,
  callPackage,
  fetchFromGitHub,
  ffmpeg,
  fftw,
  flex,
  freetype,
  gdal,
  geos,
  lapack,
  libGLU,
  libiconv,
  libpng,
  libsvm,
  libtiff,
  libxml2,
  makeWrapper,
  netcdf,
  overrideSDK,
  pdal,
  pkg-config,
  postgresql,
  proj,
  python311Packages,
  readline,
  sqlite,
  withOpenGL ? true,
  wrapGAppsHook3,
  wxGTK32,
  zlib,
  zstd,
  libGL,
  xcbuild,
}:
let
  pyPackages = python311Packages;
  stdenv' = if stdenv.isDarwin then overrideSDK stdenv "11.0" else stdenv;
in
stdenv'.mkDerivation (finalAttrs: {
  pname = "grass";
  version = "8.4.0";

  src = fetchFromGitHub {
    owner = "OSGeo";
    repo = "grass";
    rev = finalAttrs.version;
    hash = "sha256-NKMshd6pr2O62ZjmQ/oPttmeVBYVD0Nqhh3SwQrhZf8=";
  };

  nativeBuildInputs =
    [
      makeWrapper
      wrapGAppsHook3
      bison
      flex
      gdal # for `gdal-config`
      geos # for `geos-config`
      netcdf # for `nc-config`
      pkg-config
    ]
    ++ lib.optionals stdenv.isDarwin [
      xcbuild.xcrun
    ]
    ++ (with pyPackages; [
      python-dateutil
      numpy
      wxpython
    ]);

  buildInputs =
    [
      blas
      cairo
      ffmpeg
      fftw
      freetype
      gdal
      geos
      lapack
      libpng
      libsvm
      libtiff
      (libxml2.override { enableHttp = true; })
      netcdf
      pdal
      postgresql
      proj
      readline
      sqlite
      wxGTK32
      zlib
      zstd
    ]
    ++ lib.optionals withOpenGL [ libGLU ]
    ++ lib.optionals stdenv.isDarwin [
      libiconv
    ];

  strictDeps = true;

  configureFlags =
    [
      "--with-blas"
      "--with-cxx"
      "--with-fftw"
      "--with-geos"
      "--with-gdal"
      "--with-lapack"
      "--with-libsvm"
      "--with-nls"
      "--with-pdal"
      "--with-postgres"
      "--with-postgres-libs=${postgresql.lib}/lib/"
      "--with-proj-includes=${proj.dev}/include"
      "--with-proj-libs=${proj}/lib"
      "--with-proj-share=${proj}/share/proj"
      "--with-sqlite"
      "--with-zstd"
      "--without-bzlib"
      "--without-mysql"
      "--without-odbc"
    ]
    ++ lib.optionals stdenv.isLinux [
      "--with-openmp"
      "--with-cairo-ldflags=-lfontconfig"
      "--with-freetype"
    ]
    ++ lib.optionals (!withOpenGL) [
      "--without-opengl"
    ]
    ++ lib.optionals stdenv.isDarwin [
      "--enable-macosx-app"
      "--prefix=/Applications"
      "--without-cairo"
      "--without-freetype"
      "--without-x"
    ]
    ++ lib.optionals (stdenv.isDarwin && withOpenGL) [
      "--with-opengl=aqua"
    ];

  # Otherwise a very confusing "Can't load GDAL library" error
  makeFlags = lib.optional stdenv.isDarwin "GDAL_DYNAMIC=";

  /*
    Ensures that the python script run at build time are actually executable;
    otherwise, patchShebangs ignores them.
  */
  postConfigure = ''
    for f in $(find . -name '*.py'); do
      chmod +x $f
    done

    patchShebangs */
  '';

  postInstall = ''
    wrapProgram $out/bin/grass \
    --set PYTHONPATH $PYTHONPATH \
    --set GRASS_PYTHON ${pyPackages.python.interpreter} \
    --suffix LD_LIBRARY_PATH ':' '${gdal}/lib'
    ln -s $out/grass*/lib $out/lib
    ln -s $out/grass*/include $out/include
  '';

  enableParallelBuilding = true;

  passthru.tests = {
    grass = callPackage ./tests.nix { grass = finalAttrs.finalPackage; };
  };

  meta = with lib; {
    description = "GIS software suite used for geospatial data management and analysis, image processing, graphics and maps production, spatial modeling, and visualization";
    homepage = "https://grass.osgeo.org/";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; teams.geospatial.members ++ [ mpickering ];
    platforms = platforms.all;
    mainProgram = "grass";
  };
})
