# Restart Spring when any of the following changes.
[
  ".ruby-version",
  ".rbenv-vars",
  "tmp/restart.txt",
  "tmp/caching-dev.txt",
].each { |path| Spring.watch(path) }
