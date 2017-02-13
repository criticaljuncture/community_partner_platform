class DemoDataGenerator
  CITIES = ['Oakland', 'Berkeley', 'San Francisco', 'Washington, DC', 'Chicago', 'Los Angeles', 'Seattle']

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
    'Committee',
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

  NAMES = [
    'John Muir',
    'Lewis and Clark',
    'Sacagawea',
    'Neil Armstrong',
    'John Wesley Powell',
    'Martin Luther King Jr.',
    'Thomas Paine',
    'John Brown',
    'Frederick Douglass',
    'Susan B. Anthony',
    'W.E.B. Du Bois',
    'Tecumseh',
    'Sitting Bull',
    'Elizabeth Cady Stanton',
    'Malcolm X',
    'Abraham Lincoln',
    'George Washington',
    'Thomas Jefferson',
    'Theodore Roosevelt',
    'Ulysses S. Grant',
    'Ronald W. Reagan',
    'George W. Bush',
    'Franklin Roosevelt',
    'Woodrow Wilson',
    'James Madison',
    'Andrew Jackson',
    'Eleanor Roosevelt',
    'Martha Washington',
    'Hellen Keller',
    'Sojourner Truth',
    'Jane Addams',
    'Edith Wharton',
    'Bette Davis',
    'Frank Lloyd Wright',
    'Andy Warhol',
    'Frederick Law Olmsted',
    'James Abbott MacNeill Whistler',
    'Jackson Pollock',
    'John James Audubon',
    'Georgia O’Keeffe',
    'Thomas Eakins',
    'Thomas Nast',
    'Alfred Stieglitz',
    'Ansel Adams',
    'William Penn',
    'Roger Williams',
    'Anne Hutchinson',
    'Jonathan Edwards',
    'Billy Graham',
    'Mark Twain',
    'Charlie Chaplin',
    'Marilyn Monroe',
    'Frank Sinatra',
    'Louis Armstrong',
    'Mary Pickford',
    'Andrew Carnegie',
    'Henry Ford',
    'John D. Rockefeller',
    'Walt Disney',
    'Thomas Edison',
    'William Randolph Hearst',
    'Howard Hughes',
    'Bill Gates',
    'Cornelius Vanderbilt',
    'Steve Jobs',
    'Babe Ruth',
    'Muhammad Ali',
    'Jackie Robinson',
    'James Naismith',
    'Ty Cobb',
    'Michael Jordan',
    'Jim Thorpe',
    'Billie Jean King',
  ]

  POSTFIXES_SITE_TYPES = [
    ['Elementary School', 'Elementary'],
    ['Middle School', 'Middle'],
    ['High School', 'Senior'],
    ['Academy', 'random'],
    ['Tech Prep', 'random'],
    ['Charter', 'random'],
  ]

  SITE_TYPES = [
    'Elementary',
    'Middle',
    'Senior',
    'K-8',
    '6-12',
  ]

  attr_reader :elementary_region,
    :lat,
    :lng,
    :middle_region,
    :postfix,
    :senior_region,
    :site_type_norm

  def initialize
    @elementary_region = BorderPatrol.parse_kml(File.read('data/kml/ousd_elementary_2013.kml'))
    @middle_region = BorderPatrol.parse_kml(File.read('data/kml/ousd_middle_2013.kml'))
    @senior_region = BorderPatrol.parse_kml(File.read('data/kml/ousd_high_2013.kml'))
    puts 'init'
  end

  def regenerate
    types = POSTFIXES_SITE_TYPES[rand(POSTFIXES_SITE_TYPES.length)]

    @postfix = types.first
    @site_type_norm = types.last != 'random' ? types.last : SITE_TYPES[rand(SITE_TYPES.length)]
    generate_location
  end

  def get_kml_region
    case site_type_norm
    when 'Elementary', 'Middle', 'Senior'
      self.send("#{site_type_norm.downcase}_region")
    when 'K-8'
      self.send("elementary_region")
    when '6-12'
      self.send("middle_region")
    end
  end

  def generate_location
    region = get_kml_region
    bounding_box = region.bounding_box
    x = nil
    y = nil

    while !x || !y || !region.contains_point?(x,y)
      y = rand(region.bounding_box[1].y...region.bounding_box[0].y)
      x = rand(region.bounding_box[0].x...region.bounding_box[1].x)
    end

    @lng = y
    @lat = x
  end

  def name
    [
      NAMES[rand(NAMES.length)],
      postfix
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

class DemoDataGenerator::CommunityProgram < DemoDataGenerator
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
