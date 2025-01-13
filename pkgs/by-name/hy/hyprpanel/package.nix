{
  lib,
  system,
  ags,
  astal,
  bluez,
  bluez-tools,
  brightnessctl,
  btop,
  dart-sass,
  fd,
  fetchFromGitHub,
  fish,
  glib,
  gnome-bluetooth,
  gobject-introspection,
  gpu-screen-recorder,
  grimblast,
  gvfs,
  hypridle,
  hyprpicker,
  hyprsunset,
  libgtop,
  libnotify,
  matugen,
  networkmanager,
  python3,
  pywal,
  swww,
  typescript,
  upower,
  wireplumber,
}:
ags.bundle {
  pname = "hyprpanel";
  version = "unstable-2025-01-13";

  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "Jas-SinghFSU";
    repo = "HyprPanel";
    rev = "7ef79f7362fcad55c4b0c02ef1c2dee6e2cbee18";
    hash = "sha256-U3Vrx8qsyXpagAN1TLlh7nYs/vDia91L++baI6LPBsA=";
  };

  patches = [
    ./remove-broken-modules.patch
  ];

  postPatch = ''
    rm -rf src/components/bar/modules/cava
    rm -rf src/globals/systray.ts src/components/bar/modules/systray
  '';

  # keep in sync with https://github.com/Jas-SinghFSU/HyprPanel/blob/master/flake.nix#L28
  dependencies = [
    astal.apps
    astal.battery
    astal.bluetooth
    # astal.cava # TODO: broken atm
    astal.hyprland
    astal.mpris
    astal.network
    astal.notifd
    astal.powerprofiles
    # astal.tray # TODO: broken atm
    astal.wireplumber

    bluez
    bluez-tools
    brightnessctl
    btop
    dart-sass
    fd
    fish
    glib
    gnome-bluetooth
    gobject-introspection
    grimblast
    gvfs
    hypridle
    hyprpicker
    hyprsunset
    libgtop
    libnotify
    matugen
    networkmanager
    pywal
    swww
    typescript
    upower
    wireplumber
    (python3.withPackages (
      ps: with ps; [
        gpustat
        dbus-python
        pygobject3
      ]
    ))
  ] ++ (lib.optionals (system == "x86_64-linux") [ gpu-screen-recorder ]);

  # NOTE: no update script as dependencies must be kept in sync with upstream
  # and it is problematic to do it in an update script. I don't have push
  # access to r-ryantm's repo, so I will just do updates manually

  meta = {
    description = "Bar/Panel for Hyprland with extensive customizability";
    homepage = "https://github.com/Jas-SinghFSU/HyprPanel";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ perchun ];
    mainProgram = "hyprpanel";
    platforms = lib.platforms.linux;
  };
}
