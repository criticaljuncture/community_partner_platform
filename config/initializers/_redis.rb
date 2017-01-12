REDIS_CONNECTION_SETTINGS = {
  db: ENV["REDIS_DB"] || 0,
  host: ENV["REDIS_HOST"] || '127.0.0.1',
  port: ENV["REDIS_PORT"] || 6379
}

$redis = Redis.new(REDIS_CONNECTION_SETTINGS)

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    # We're in smart spawning mode.
    if forked
      $redis.client.disconnect
      $redis = Redis.new(REDIS_CONNECTION_SETTINGS)
    end
  end
end
