namespace :demo do
  task :generate_data => :environment do
    generate_organizations(50)
    generate_schools(50)
    generate_users(20, type: :school_manager)
    generate_users(40, type: :organization_member)
    generate_partnerships(200)
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


      organization = Organization.new(name:         name,
                                      url:          url,
                                      address:      address,
                                      city:         city,
                                      zip_code:     zip_code,
                                      phone_number: phone_number)
      organization.save
      organizations << organization
    end

    organizations
  end

  def generate_schools(count)
    data_generator = DemoDataGenerator::School.new

    schools = []
    names = []

    count.times do
      name = data_generator.name
      region = Region.find(data_generator.region)

      # prevent duplicate schools
      next if names.include?(name)
      names << name

      school = School.new(name:   name,
                          region: region)
      school.save
      schools << school
    end

    schools
  end

  def generate_users(count, args)
    type = args[:type]
    data_generator = DemoDataGenerator::User.new(type)

    users = []
    emails = []

    count.times do
      first_name = data_generator.first_name
      last_name  = data_generator.last_name
      roles = Array(data_generator.role)
      email = data_generator.email(first_name, last_name)
      subdomain = 'demo'

      # prevent duplicate users
      next if emails.include?(email)
      emails << email

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

      user = User.new(first_name:   first_name,
                      last_name:    last_name,
                      email:        email,
                      roles:        roles,
                      schools:      schools,
                      organization: organization,
                      subdomain:    subdomain)

      user.admin_creation = true
      user.save
      users << user
    end

    users
  end

  def generate_partnerships(count)
    data_generator = DemoDataGenerator::CommunityPartner.new

    partnerships = []
    count.times do
      name = data_generator.name
      organization = Organization.order("RAND()").limit(1).first
      school = School.order("RAND()").limit(1).first

      school_users = User.includes(:schools).where(schools: {id: school.id})
      school_user  = school_users[rand(school_users.count)]

      organization_users = User.where(organization_id: organization.id)
      organization_user = organization_users[rand(organization_users.count)]

      # org users are required
      next unless organization_user

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
      primary_quality_element = CommunityPartnerQualityElement.new(quality_element: quality_element, type: 'PrimaryQualityElement')

      service_types = ServiceType.includes(:quality_elements).where(quality_elements: {id: quality_element.id}).order("RAND()")
      primary_quality_element.service_types = [service_types.first, service_types.last]

      community_partner = CommunityPartner.new(name:                      name,
                                               organization:              organization,
                                               user:                      organization_user,
                                               school:                    school,
                                               school_user:               school_user,
                                               primary_quality_element:   primary_quality_element,
                                               student_population:        student_population,
                                               ethnicity_culture_groups:  ethnicity_culture_groups,
                                               demographic_groups:        demographic_groups,
                                               grade_levels:              grade_levels,
                                               service_times:             service_times,
                                               days:                      days)
      community_partner.save
      partnerships << community_partner
    end

    partnerships
  end
end
