# Patched by Gentix
{
  bootstrapTools = import <nix/fetchurl.nix> {
    url = "http://gentix.perchun.it/fz1qf4q2q0wy09851jkdgwqyg3d1ssrr/bootstrap-tools.tar.xz";
    hash = "sha256-AdmqALuumt/E3DjtnVUPaWCj/Fd5nwmP90k4zsem7tw=";
  };
  busybox = import <nix/fetchurl.nix> {
    url = "http://gentix.perchun.it/c7prqdlcx64nnl70qq2ysyj0507kn311/busybox";
    hash = "sha256-1jkA+JbCQhjDlBtUx8Qu5aaMO89SxvxOad21j8ypOtg=";
    executable = true;
  };
}
