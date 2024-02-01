{ lib
, pkgs
, config
, ...
}:
let
  cfg = config.programs.nwg-hello;
  settingsFormat = pkgs.formats.json { };
in
{
  options.programs.nwg-hello = {
    enable = lib.mkEnableOption null // {
      description = lib.mdDoc ''
        Enable nwg-hello, a clean and customizable greeter for greetd.

        To use nwg-hello, {option}`services.greetd` has to be enabled and
        {option}`services.greetd.settings.default_session` should contain the
        appropriate configuration to launch
        {option}`config.programs.nwg-hello.package`. For examples, see the
        [nwg-hello Readme](https://github.com/rharish101/nwg-hello#set-as-default-session).

        A minimal configuration that launches nwg-hello in {command}`cage` is
        enabled by this module by default.
      '';
    };

    package = lib.mkPackageOption pkgs [ "nwg-hello" ] { };

    settings = lib.mkOption {
      type = lib.types.either lib.types.path settingsFormat.type;
      default = { };
      description = lib.mdDoc ''
        nwg-hello configuration file. Refer
        <https://github.com/rharish101/nwg-hello/blob/main/nwg-hello.sample.toml>
        for options.
      '';
    };

    cageArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "-s" ];
      example = lib.literalExpression
        ''
          [ "-s" "-m" "last" ]
        '';
      description = lib.mdDoc ''
        Additional arguments to be passed to
        [cage](https://github.com/cage-kiosk/cage).
      '';
    };

    extraCss = lib.mkOption {
      type = lib.types.either lib.types.path lib.types.lines;
      default = "";
      description = lib.mdDoc ''
        Extra CSS rules to apply on top of the GTK theme. Refer to
        [GTK CSS Properties](https://docs.gtk.org/gtk4/css-properties.html) for
        modifiable properties.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = lib.mkDefault true;
      settings.default_session.command = lib.mkDefault "${pkgs.dbus}/bin/dbus-run-session ${lib.getExe pkgs.cage} ${lib.escapeShellArgs cfg.cageArgs} -- ${lib.getExe cfg.package}";
    };

    environment.etc = {
      "nwg-hello/nwg-hello.css" =
        if lib.isPath cfg.extraCss
        then { source = cfg.extraCss; }
        else { text = cfg.extraCss; };

      "nwg-hello/nwg-hello.json".source =
        if lib.isPath cfg.settings
        then cfg.settings
        else (builtins.fromJSON (builtins.readFile "${pkgs.nwg-hello}/etc/nwg-hello/nwg-hello-default.json")) // settingsFormat.generate "nwg-hello.json" cfg.settings;
    };

    systemd.tmpfiles.settings."10-nwg-hello" =
      let
        user = config.services.greetd.settings.default_session.user;

        defaultConfig = {
          inherit user;
          group = config.users.users.${user}.group;
          mode = "0755";
        };
      in
      {
        "/var/log/nwg-hello".d = defaultConfig;
        "/var/cache/nwg-hello".d = defaultConfig;
      };
  };
}
