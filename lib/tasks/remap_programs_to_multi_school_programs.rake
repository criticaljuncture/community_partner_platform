namespace :remap do
  task :community_programs_to_school_programs => :environment do
    CommunityProgram.unscoped.all.each do |community_program|
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
    #Organization.unscoped.includes(:community_programs).all.each do |organization|
      organization = Organization.includes(:community_programs).find(5)

      program_names = organization.community_programs.map(&:name).uniq

      program_names.each do |name|
        programs = organization.community_programs.where(name: name).to_a
        master_program = programs.shift

        programs.each do |program|
          if collapsible?(master_program, program)
            program.school_programs.each do |collapsible_program|
              collapsible_program.community_program_id = master_program.id

              collapsible_program.delegated_if_blank_methods.each do |method|
                # create customized attributes where the collapsible_program
                # differs from the master_program
                unless collapsible_program.send(method) == master_program.send(method)
                  collapsible_program.send(
                    "#{method}=",
                    collapsible_program.send(method)
                  )
                end
              end

              collapsible_program.save
            end

            program.destroy
          end
        end
      end
    #end
  end

  # programs are collapsible if they have similar community program values
  # (defined below) and similar descriptions. Otherwise they are collapsible
  # if their descriptions are different but the community program values and
  # select school program values are similar. 
  def collapsible?(master_program, program)
    community_program_values_similar = [:quality_element, :service_types].all? do |method|
      program.send(method).blank? || master_program.send(method) == program.send(method)
    end

    method = :service_description
    description_similar = program.send(method).blank? || master_program.send(method) == program.send(method)

    if community_program_values_similar && description_similar
      true
    else
      school_program_values_similar = [:student_population, :demographic_groups].all? do |method|
        program.send(method).blank? || master_program.send(method) == program.send(method)
      end

      community_program_values_similar && school_program_values_similar
    end
  end
end
