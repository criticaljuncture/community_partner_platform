namespace :completion_rates do
  task :calculate_all => :environment do
    Organization.all.each{|o| o.save(validate: false)}
    CommunityProgram.active.all.each{|cp| cp.save(validate: false)}
    SchoolProgram.all.each{|sp| sp.save(validate: false)}
  end
end
