REDIS_CONNECTION_SETTINGS = {
  db: ENV["REDIS_DB"] || 0,
  host: ENV["REDIS_PORT_6379_TCP_ADDR"] || '127.0.0.1',
  port: ENV["REDIS_PORT_6379_TCP_PORT"] || 6379
}

$redis = Redis.new(REDIS_CONNECTION_SETTINGS)
