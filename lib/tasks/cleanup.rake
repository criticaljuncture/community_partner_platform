namespace :cleanup do
  task :strip_whitespace_in_community_program_names => :environment do
    CommunityProgram.unscoped.all.each do |program|
      program.name = program.name.strip
      program.save(validate: false)
    end
  end

  task :strip_whitespace_in_organization_names => :environment do
    Organization.unscoped.all.each do |organization|
      organization.name = organization.name.strip
      organization.save(validate: false)
    end
  end

  task :map_school_network_to_region => :environment do
    School.where('network IS NOT NULL').each do |school|
      school.region_id = Region.find_by_network(school.network).id
      school.save
    end
  end

  task :set_subdomain_for_current_users => :environment do
    User.all.each do |user|
      user.subdomain = 'ousd'
      user.save(verify: false)
    end
  end

  task :remove_service_type_mappings_and_clean_up => :environment do
    # quality_element_id => [service_type_ids]
    mappings_to_remove = {
      # Academic & Social Emotional Learning
      1 => [1, 2, 4, 5, 6, 7, 9, 12, 13, 16, 24, 25, 26, 27, 28, 29, 30, 31, 33, 36, 37, 41, 44, 45],
      3 => [2, 34, 35, 45],
      5 => [1, 2, 15, 17, 30, 32, 35, 39, 45],
      6 => [1, 3, 5, 6, 7, 9, 11, 13, 16, 20, 21, 26, 30, 31, 33, 34, 37, 41, 43, 44, 45],
      7 => [1, 2, 3, 10, 15, 17, 24, 25, 32, 34, 35, 36],
      8 => [2, 4, 11, 12, 21, 24, 25, 36, 41, 44],
      # remove 9 entirely and add new one
      10 => [1, 2, 6, 18, 27, 28, 29, 34, 35, 43, 45],
      11 => [2, 10, 14, 15, 16, 17, 19, 21, 23, 30, 32, 39, 40, 42],
      12 => [2, 5, 6, 9, 14, 23, 24, 25, 30, 36, 41, 42, 44]
    }


    mappings_to_remove.each do |quality_element_id, service_type_ids|
      # remove community program mappings
      CommunityProgram.connection.execute(<<-SQL)
        DELETE community_program_quality_element_service_types
        FROM community_program_quality_element_service_types
        JOIN community_program_quality_elements
          ON community_program_quality_elements.id = community_program_quality_element_service_types.community_program_quality_element_id
        WHERE community_program_quality_element_service_types.service_type_id IN (#{service_type_ids.join(',')})
          AND community_program_quality_elements.quality_element_id = #{quality_element_id}
      SQL

      # remove unmapped service types
      ServiceType.connection.execute(<<-SQL)
        DELETE quality_element_service_types
        FROM quality_element_service_types
        WHERE quality_element_service_types.quality_element_id = #{quality_element_id}
          AND quality_element_service_types.service_type_id IN (#{service_type_ids.join(',')})
      SQL
    end
  end

  task :deactivate_school_program_if_community_program_not_active => :environment do
    CommunityProgram.unscoped.where(active: false).each do |community_program|
      community_program.school_programs.each do |program|
        program.active = false
        program.active_changed_by = community_program.active_changed_by
        program.active_changed_on = community_program.active_changed_on
        program.save(verify: false)
      end
    end
  end

  task :convert_ousd_users_email_addresses => :environment do
    users = User.where('email like "%ousd.k12.ca.us"').where(subdomain: 'ousd')

    users.each do |user|
      user.email = user.email.gsub('ousd.k12.ca.us', 'ousd.org')
      user.save(verify: false)
    end
  end
end
