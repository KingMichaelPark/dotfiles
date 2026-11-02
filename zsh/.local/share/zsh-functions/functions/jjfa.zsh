jjfa() {
  for dir in */(N); do
    if [[ -d "$dir/.jj" ]]; then
      echo "==> $dir"
      (builtin cd -q -- "$dir" && jj git fetch)
    fi
  done
}
