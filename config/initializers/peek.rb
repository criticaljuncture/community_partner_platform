if Rails.env.development?
  Peek.into Peek::Views::Git, :nwo => 'peregrinator/community_partners_platform', :domain => 'github.com', :protocol => 'https'
  Peek.into Peek::Views::Mysql2
  Peek.into Peek::Views::GC
  Peek.into Peek::Views::PerformanceBar
  Peek.into Peek::Views::Rblineprof
  Peek.into Peek::Views::Dalli
end
