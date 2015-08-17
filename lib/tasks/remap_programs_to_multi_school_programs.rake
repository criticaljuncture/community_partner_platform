namespace :remap do
  task :community_programs_to_school_programs => :environment do
    CommunityProgram.unscoped.all.each do |community_program|
      SchoolProgram.new(
        community_program_id: community_program.id,
        school_id: community_program.school_id,
        school_user_id: community_program.school_user_id
      ).save
    end
  end
end
