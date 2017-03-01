%w(
  config/application_config/
  lib/application_config/
).each { |path| Spring.watch(path) }
