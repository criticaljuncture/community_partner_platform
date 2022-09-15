roles = [
  ['Super Admin', :super_admin],
  ['District Manager', :district_manager],
  ['School Manager', :school_manager],
  ['Organization Member', :organization_member]
]

Role.truncate
roles.each do |name, identifier|
  r = Role.new(name: name, identifier: identifier)
  r.save
end

quality_elements = [
  {
    identifier: "social_emotional_learning",
		name: "Academic & Social Emotional Learning",
		type: "programmatic"
	},
  {
    identifier: "collaborative_leadership",
		name: "Collaborative Leadership",
		type: "foundational"
	},
  {
    identifier: "continuous_improvement",
		name: "Continuous Improvement",
		type: "foundational"
	},
  {
    identifier: "coordination",
		name: "Partnerships and Coordination",
		type: "foundational"
	},
  {
    identifier: "equity_diversity",
		name: "Equity and Diversity",
		type: "foundational"
	},
  {
    identifier: "expanded_learning",
		name: "Expanded Learning",
		type: "programmatic"
	},
  {
    identifier: "family_engagement_support",
		name: "Family Engagement & Support",
		type: "programmatic"
	},
  {
    identifier: "health_wellness",
		name: "Health & Wellness",
		type: "programmatic"
	},
  {
    identifier: "school_culture_climate",
		name: "School Culture & Climate",
		type: "programmatic"
	},
  {
    identifier: "school_readiness_transitions",
		name: "School Readiness & Transitions",
		type:  "programmatic"
	},
  {
    identifier: "youth_leadership",
		name: "Youth leadership",
		type: "programmatic"
	},
]

quality_elements.each do |quality_element|
  ql = QualityElement.find_or_create_by(
    identifier: quality_element[:identifier]
  )

  ql.update(
    name: quality_element[:name],
    element_type: quality_element[:type]
  )
end

service_types = [
  "Activism/social justice",
  "After school and youth development",
  "Attendance Interventions",
  "Classes for parents and family members",
  "College exposure, engagement, and preparation",
  "Conflict resolution education and activities",
  "Credit Recovery",
  "Direct medical services",
  "Drug and Alcohol Prevention",
  "Engineering education and activities",
  "Food Distribution",
  "Gardening",
  "Health education and enrichment",
  "Linked Learning",
  "Literacy education and activities",
  "Manhood/Womanhood Development",
  "Math education and activities",
  "Mental health interventions and services",
  "Mentoring",
  "Nutrition education and enrichment activities",
  "Parent and family engagement and education activities",
  "Partnership Coordination",
  "Performing arts education and enrichment activities",
  "Physical Education and exercise activities, dance and performance",
  "Physical Education and exercise activities, sports and athletics",
  "Positive Behavioral Interventions and Supports (PBIS)",
  "Professional development for administrators",
  "Professional development for all staff",
  "Professional development for teachers",
  "Restorative Justice",
  "Saturday School",
  "Science education and activities",
  "Sex education",
  "Social emotional education and activities",
  "Special education activities and services",
  "Summer Enrichment",
  "Supplemental Educational Services",
  "Technology assistance for school staff",
  "Technology education and activities",
  "Tutoring",
  "Violence Prevention",
  "Visual arts education and enrichment activities",
  "Volunteer recruitment, training, and/or management",
  "Workforce exposure, engagement, and preparation",
  "Youth leadership"
]

ServiceType.truncate
service_types.each do |name|
  st = ServiceType.new(name: name)
  st.save(validate: false)
end

days = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
  "Varies"
]

Day.truncate
days.each do |name|
  d = Day.new(name: name)
  d.save
end

ethnicity_culture_groups  = [
  "All Students",
  "African American",
  "Asian",
  "Filipino",
  "Pacific Islander",
  "Native American",
  "White",
  "Hispanic/Latino",
  "Arabic Speakers",
  "Other"
]

EthnicityCultureGroup.truncate
ethnicity_culture_groups.each do |name|
  ecg = EthnicityCultureGroup.new(name: name)
  ecg.save
end

demographic_groups = [
  "All Students",
  "By Application",
  "By Referral Only",
  "Chronically Absent Youth",
  "English Language Learners",
  "Foster Youth",
  "High Performing Youth",
  "High Risk Youth (Drugs and Alcohol)",
  "High Risk Youth (Violence)",
  "Homeless Youth",
  "Juvenile Justice/Probation Youth",
  "LGBTQ Youth",
  "Students with Disabilities",
  "Students with Mental Health Needs",
  "Students with Social Service Needs",
  "Undocumented Students",
  "Students with Special Needs"
]

DemographicGroup.truncate
demographic_groups.each do |name|
  dg = DemographicGroup.new(name: name)
  dg.save
end


grade_levels  = [
  "Pre-Kindergarten",
  "Transitional Kindergarten",
  "Kindergarten",
  "1st Grade",
  "2nd Grade",
  "3rd Grade",
  "4th Grade",
  "5th Grade",
  "6th Grade",
  "7th Grade",
  "8th Grade",
  "9th Grade",
  "10th Grade",
  "11th Grade",
  "12th Grade",
  "Post-Secondary"
]

GradeLevel.truncate
grade_levels.each do |name|
  gl = GradeLevel.new(name: name)
  gl.save
end

student_populations = [
  "All Students",
  "Female Students",
  "Male Students",
  "Parents/ Families",
  "Teachers",
  "School Administrators",
  "School Staff"
]

StudentPopulation.truncate
student_populations.each do |name|
  sp = StudentPopulation.new(name: name)
  sp.save
end


service_times = [
  "Advisory",
  "After school",
  "Before school",
  "During school",
  "Holidays",
  "Monthly",
  "Summer",
  "Varies"
]

ServiceTime.truncate
service_times.each do |name|
  st = ServiceTime.new(name: name)
  st.save
end


legal_statuses = [
  'Public agency',
  'Non-profit organization with its own 501c3 status',
  'Non-profit organization working under fiscal sponsorship of another agency',
  'Sole proprietorship or consultancy',
  'LLC or LLP',
  'Corporation',
  'Ad hoc committee or group',
  'Interested individual',
  'Other',
]

LegalStatus.truncate
legal_statuses.each do |name|
  ls = LegalStatus.new(name: name)
  ls.save
end
