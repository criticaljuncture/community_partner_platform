class DemoDataGenerator
  CITIES = ['Oakland', 'Berkeley', 'San Francisco', 'Washington, DC', 'Chicago', 'Los Angeles']

  def url(name)
    "http://www.#{name.split(' ').join.downcase}.com"
  end

  def city
    CITIES[rand(CITIES.length)]
  end
end

class DemoDataGenerator::Organization < DemoDataGenerator
  PREFIXES = [
    'Urban',
    'Exceptional',
    'Commitee for',
    'Alliance of',
  ]
  NAMES = [
    'Youth',
    'Health',
    'Kids First',
    'Children',
    'Transition',
    'Partnership',
  ]
  POSTFIXES = [
    'East Bay',
    'Bay Area',
    'Northern California',
    'Commitee',
    'Academy',
  ]

  def name
    [
      PREFIXES[rand(PREFIXES.length + 1)],
      NAMES[rand(NAMES.length)],
      POSTFIXES[rand(POSTFIXES.length + 1)],
    ].compact.join(' ')
  end
end

class DemoDataGenerator::School < DemoDataGenerator
  REGION_IDS = [1,2,3,4]

  NAMES = %w(alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu nu xi omicron pi rho sigma tau upsilon phi chi psi omega)
  POSTFIXES = [
    'Elementary School',
    'Middle School',
    'High School',
    'Academy',
    'Tech Prep',
    'Charter',
  ]

  def name
    [
      NAMES[rand(NAMES.length)].capitalize,
      POSTFIXES[rand(POSTFIXES.length)]
    ].join(' ')
  end

  def region
    REGION_IDS[rand(REGION_IDS.length)]
  end
end

class DemoDataGenerator::User < DemoDataGenerator
  attr_accessor :role

  def initialize(type)
    @role = Role.find_by_identifier!(type)
  end

  FIRST_NAMES = %w(James Robert John William Richard Charles David Thomas Donald Ronald George Joseph Larry Jerry Kenneth Edward Paul Michael Gary Frank Gerald Raymond Harold Dennis Walter Mary Barbara Patricia Judith Betty Carol Nancy Linda Shirley Sandra Margaret Dorothy Joyce Joan Carolyn Judy Sharon Helen Janet Elizabeth Virginia Janice Donna Ruth Marilyn)
  def first_name
    FIRST_NAMES[rand(FIRST_NAMES.length)]
  end

  LAST_NAMES = %w(Smith Brown Lee Wilson Martin Patel Taylor Wong Campbell Williams Thompson Jones Tremblay Roy Gagnon Bouchard Gauthier Morin Lavoie Fortin Martinez Garcia Hernandez Gonzalez Lopez Rodriguez Perez Sanchez Ramirez Flores)
  def last_name
    LAST_NAMES[rand(LAST_NAMES.length)]
  end

  def email(first_name, last_name)
    "#{first_name.downcase}.#{last_name.downcase}@example.com"
  end
end

class DemoDataGenerator::CommunityPartner < DemoDataGenerator
  PREFIXES = [
    '180',
    '360',
    '720',
    'West',
    'East',
    'North',
    'South',
    'Oakland',
    'East Bay',
  ]
  NAMES = [
    'Literacy',
    'Justice',
    'Physical Education',
    'Media',
    'Healthy Lifestyle'
  ]
  POSTFIXES = [
    'Together',
    'Pathway',
    'Connection',
    'Center',
    'Consortium',
  ]

  def name
    [
      PREFIXES[rand(PREFIXES.length + 1)],
      NAMES[rand(NAMES.length)],
      POSTFIXES[rand(POSTFIXES.length + 1)],
    ].compact.join(' ')
  end
end
