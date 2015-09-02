namespace :cleanup do
  task :strip_whitespace_in_community_program_names => :environment do
    CommunityProgram.unscoped.all.each do |program|
      program.name = program.name.strip
      program.save(validate: false)
    end
  end
end
