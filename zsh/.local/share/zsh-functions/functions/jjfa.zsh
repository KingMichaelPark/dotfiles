jjfa() {
  for dir in */; do
    if [ -d "$dir/.jj" ]; then
      echo "==> $dir"
      (cd "$dir" && jj git fetch)
    fi
  done
}
