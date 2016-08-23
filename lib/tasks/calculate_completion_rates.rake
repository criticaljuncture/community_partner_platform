namespace :completion_rates do
  task :calculate_all => :environment do
    Organization.all.each{|o| o.update_completion_rate}
    CommunityProgram.all.each{|cp| cp.update_completion_rate}
    SchoolProgram.all.each{|sp| sp.update_completion_rate}
  end
end
