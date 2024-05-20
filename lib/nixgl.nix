{ pkgs, nixGL ? "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL", ... }:

binary: drv: pkgs.symlinkJoin {
  name = "${drv.name}-nixglwrapped";
  paths = [ drv ];
  nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
  version = drv.version or "";
  postBuild = ''
    makeBinaryWrapper \
      "${nixGL}" \
      "$out/bin/${binary}" \
      --inherit-argv0 \
      --add-flags "${drv}/bin/${binary}"
  '';
}
