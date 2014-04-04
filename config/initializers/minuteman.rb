Minuteman::Rails.configure do |c|
  c.silent = true
  c.redis = Redis::Namespace.new(:minuteman, :redis => $redis)
end
