namespace :demo do
  task :generate_data => :environment do
    reset_db
    generate_organizations(50)
    generate_schools(50)
    generate_users(20, type: :school_manager)
    generate_users(40, type: :organization_member)
    generate_admins
    generate_partnerships(200)
  end

  def reset_db
    Organization.truncate
    School.truncate
    User.truncate
    UserRole.truncate

    CommunityProgram.truncate
    CommunityProgramDemographicGroup.truncate
    CommunityProgramEthnicityCultureGroup.truncate
    CommunityProgramGradeLevel.truncate
    CommunityProgramQualityElement.truncate
    CommunityProgramQualityElementServiceType.truncate
    CommunityProgramServiceDay.truncate
    CommunityProgramServiceTime.truncate

    SchoolProgram.truncate
  end

  def generate_organizations(count)
    data_generator = DemoDataGenerator::Organization.new

    organizations = []
    org_names = []

    count.times do
      name = data_generator.name
      url = data_generator.url(name)
      address = "555 Main St."
      city = data_generator.city
      zip_code = "12345"
      phone_number = "(555) 555-5555"

      # prevent duplicate orgs
      next if org_names.include?(name)
      org_names << name

      organization = Organization.new(
        name:         name,
        url:          url,
        address:      address,
        city:         city,
        zip_code:     zip_code,
        phone_number: phone_number
      )
      organization.save(validate: false)
      organizations << organization
    end

    organizations
  end

  def generate_schools(count)
    data_generator = DemoDataGenerator::School.new;0

    schools = []
    names = []

    count.times do
      data_generator.regenerate
      name = data_generator.name
      region = Region.find(data_generator.region)

      # prevent duplicate schools
      next if names.include?(name)
      names << name

      school = School.new(
        name: name,
        region: region,
        site_type_norm: data_generator.site_type_norm,
        lat: data_generator.lat,
        lng: data_generator.lng
      )
      school.save(validate: false)
      schools << school
    end

    schools
  end

  def generate_admins
    user = User.new(
      first_name:   'Bob',
      last_name:    'Burbach',
      email:        'bob@criticaljuncture.org',
      roles:        Array(Role.find_by_identifier(:super_admin)),
      subdomain:    'demo',
      active:       true
    )

    user.admin_creation = true
    user.save(validate: false)
  end

  def generate_users(count, args)
    type = args[:type]
    data_generator = DemoDataGenerator::User.new(type)

    users = []

    count.times do
      first_name = data_generator.first_name
      last_name  = data_generator.last_name
      roles = Array(data_generator.role)
      email = data_generator.email(first_name, last_name)
      subdomain = 'demo'

      # prevent duplicate users
      next if User.find_by_email(email)

      # set up base state
      schools = []
      organization = nil

      # overwrite base state with proper values
      case type
      when :school_manager
        schools = School.order("RAND()").limit(3)
      when :organization_member
        organization = Organization.where(id: rand(Organization.count)).first
      end

      user = User.new(
        first_name:   first_name,
        last_name:    last_name,
        email:        email,
        roles:        roles,
        schools:      schools,
        organization: organization,
        subdomain:    subdomain
      )

      user.admin_creation = true
      user.save(validate: false)
      users << user
    end

    users
  end

  def generate_partnerships(count)
    data_generator = DemoDataGenerator::CommunityProgram.new

    partnerships = []
    count.times do
      name = data_generator.name
      organization = Organization.order("RAND()").limit(1).first

      # generate random user that match this organization
      organization_users = User.where(organization_id: organization.id)
      organization_user = organization_users[rand(organization_users.count)]

      # org users are required
      next unless organization_user

      # generate random attributes
      student_population = StudentPopulation.order("RAND()").first

      groups = EthnicityCultureGroup.order("RAND()").limit(2)
      ethnicity_culture_groups = [groups.first, groups.last]

      groups = DemographicGroup.order("RAND()").limit(2)
      demographic_groups = [groups.first, groups.last]

      groups = GradeLevel.order("RAND()").limit(2)
      grade_levels = [groups.first, groups.last]

      groups = ServiceTime.order("RAND()").limit(2)
      service_times = [groups.first, groups.last]

      groups = Day.order("RAND()").limit(2)
      days = [groups.first, groups.last]

      quality_element = QualityElement.order("RAND()").first
      primary_quality_element = CommunityProgramQualityElement.new(
        quality_element: quality_element,
        type: 'PrimaryQualityElement'
      )

      #service_types = ServiceType.includes(:quality_elements).where(quality_elements: {id: quality_element.id}).order("RAND()")
      #primary_quality_element.service_types = [service_types.first, service_types.last]

      # generate program
      community_program = CommunityProgram.new(
        name:                      name,
        active:                    true,
        organization:              organization,
        user:                      organization_user,
        primary_quality_element:   primary_quality_element,
        student_population:        student_population,
        ethnicity_culture_groups:  ethnicity_culture_groups,
        demographic_groups:        demographic_groups,
        grade_levels:              grade_levels,
        service_times:             service_times,
        days:                      days
      )

      # add a random number of schools (1-10) to this program
      schools = School.order("RAND()").limit(rand(10)+1)
      schools.each do |school|
        school_users = User.includes(:schools).where(schools: {id: school.id})
        school_user  = school_users[rand(school_users.count)]

        community_program.school_programs << SchoolProgram.new(
          school: school,
          user: school_user
        )
      end

      community_program.save(validate: false)

      partnerships << community_program
    end

    partnerships
  end

  desc "Add random school codes to demo schools"
  task :add_school_codes => :environment do
    school_codes = ['0100065','0100123','0100701','0100792','0101469','0102988','0106542','0106906','0108803','0108944','0109819','0109983','0110189','0110239','0110247','0110254','0110262','0111476','0112763','0112771','0112789','0112797','0112805','0112813','0114363','0114454','0114868','0115014','0115204','0115238','0115386','0115576','0115584','0115592','0115600','0115618','0115626','0115667','0116137','0118224','0118653','0120188','0123711','0125161','0125716','0125856','0126748','0130146','0130179','0130575','0130617','0130633','0130666','0132688','0135905','0136051','0137943','3030772','6001630','6001648','6001655','6001663','6001689','6001697','6001713','6001739','6001754','6001812','6001820','6001838','6001846','6001853','6001879','6001895','6001903','6001911','6001929','6001945','6001978','6001994','6002018','6002042','6002059','6002075','6002083','6002091','6002109','6002117','6002125','6002141','6002174','6002182','6002190','6002216','6002273','6056998','6057004','6057020','6057046','6057061','6057079','6057087','6057095','6066450','6072235','6096523','6098701','6111660','6114011','6117394','6117568','6117972','6118608','6118616','6118640','6118657']

    School.all.each do |school|
      position = rand(school_codes.length)

      school.school_code = school_codes[position]
      school.save(validate: false)

      school_codes.delete_at(position)
    end
  end
end
