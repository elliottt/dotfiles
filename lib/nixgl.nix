{ pkgs, ... }:

binary: drv: pkgs.symlinkJoin {
  name = "${drv.name}-nixglwrapped";
  paths = [ drv ];
  nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
  version = drv.version or "";
  postBuild = ''
    makeBinaryWrapper \
      "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL" \
      "$out/bin/${binary}" \
      --inherit-argv0 \
      --add-flags "${drv}/bin/${binary}"
  '';
}
