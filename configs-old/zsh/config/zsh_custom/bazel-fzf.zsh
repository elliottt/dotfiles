
# Auto-complete for bazel
_fzf_complete_bazel() {
  local tokens
  tokens=(${(z)LBUFFER})

  if [ ${#tokens[@]} -ge 3 ] && [ "${tokens[2]}" = "test" ]; then
    _fzf_complete '-m' "$@" < <(command bazel query 'tests(//...)' 2> /dev/null)
  else
    _fzf_complete '-m' "$@" < <(command bazel query '//...' 2> /dev/null)
  fi
}
