namespace :remap do
  task :community_programs_to_school_programs => :environment do
    CommunityProgram.all.each do |community_program|
      SchoolProgram.new(
        community_program_id: community_program.id,
        school_id: community_program.school_id,
        user_id: community_program.school_user_id
      ).save
    end
  end

  # as part of allowing a community program to have multiple schools we want
  # to collapse community programs that are similar into a single community
  # program with multiple school programs. The criteria for similar is defined
  # in the collapsible? method.
  task :similar_community_programs_to_single_program => :environment do
    Organization.unscoped.includes(:community_programs).all.each do |organization|
      program_names = SimilarProgramClassifier.normalize_program_names(
        organization.community_programs.map(&:name).uniq
      )

      program_names.each do |normalized_name, original_names|
        programs = organization.community_programs.where(name: original_names).to_a
        #master_program = programs.shift
        master_programs = programs.dup

        programs.each do |program|
          master_programs.each do |master_program|
            next if master_program == program

            classifier = SimilarProgramClassifier.new(
              master_program: master_program,
              program: program
            )

            if classifier.collapsible?
              SimilarProgramCollapser.perform(master_program, program)
              master_programs -= [program]
            end
          end
        end
      end
    end
  end
end
