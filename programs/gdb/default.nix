{ ... }:

{
  home.file = {
    ".config/gdb/gdbinit".text = ''
    set disassemble-next-line on

    set pretty print on
    '';
  };
}
