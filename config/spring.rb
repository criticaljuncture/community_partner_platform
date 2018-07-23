%w[
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
  config/application_config/
  lib/application_config/
].each { |path| Spring.watch(path) }
