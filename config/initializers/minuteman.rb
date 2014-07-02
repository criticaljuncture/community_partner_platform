namespace = "minuteman_#{Rails.env}".to_sym

Minuteman::Rails.configure do |c|
  c.silent = true
  c.redis = Redis::Namespace.new(namespace, :redis => $redis)
end
