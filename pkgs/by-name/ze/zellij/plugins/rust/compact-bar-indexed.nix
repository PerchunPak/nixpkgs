{ callPackage }:
let
  tab-bar = callPackage ./tab-bar-indexed { };
  compact-bar = tab-bar.override { _binary = "compact-bar"; };
  withDescription = compact-bar.overrideAttrs (old: {
    meta = old.meta // {
      description = "Toggle Zellij pane frames based on different conditions";
    };
  });
in
withDescription
