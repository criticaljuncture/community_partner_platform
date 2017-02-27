%w(
  config/application_config/
).each { |path| Spring.watch(path) }
