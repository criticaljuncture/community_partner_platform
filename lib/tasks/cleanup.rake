namespace :cleanup do
  task :strip_whitespace_in_community_program_names => :environment do
    CommunityProgram.unscoped.all.each do |program|
      program.name = program.name.strip
      program.save(validate: false)
    end
  end

  task :map_school_network_to_region => :environment do
    School.where('network IS NOT NULL').each do |school|
      school.region_id = Region.find_by_network(school.network).id
      school.save
    end
  end
end
