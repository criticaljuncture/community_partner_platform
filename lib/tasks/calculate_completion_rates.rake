namespace :completion_rates do
  task :calculate_all => :environment do
    Organization.all.each{|o| o.update_program_completion_rate}
    CommunityProgram.all.each{|o| o.update_program_completion_rate}
    SchoolProgram.all.each{|o| o.update_program_completion_rate}
  end
end
