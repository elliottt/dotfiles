{ config, pkgs, ... }:

{
  programs.zsh.initContent = ''
    # Bazel autocompletion for fzf
    _fzf_complete_bazelisk() {
      case "$@" in
        "bazelisk test"*)
          _fzf_complete --multi -- "$@" < <( \
            command bazelisk query "kind('(test|test_suite) rule', //...)" 2> /dev/null \
          )
          ;;

        *)
          _fzf_complete --multi -- "$@" < <( \
            command bazelisk query "kind('(binary rule)|(generated file)', deps(//...))" 2> /dev/null \
          )
          ;;
      esac
    }

    _fzf_complete_bazel() {
      case "$@" in
        "bazel test"*)
          _fzf_complete --multi -- "$@" < <( \
            command bazel query "kind('(test|test_suite) rule', //...)" 2> /dev/null \
          )
          ;;

        *)
          _fzf_complete --multi -- "$@" < <( \
            command bazel query "kind('(binary rule)|(generated file)', deps(//...))" 2> /dev/null \
          )
          ;;
      esac
    }
  '';
}
