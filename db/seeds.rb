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
  ["Academic & Social Emotional Learning", "programmatic"],
  ["Collaborative Leadership", "foundational"],
  ["Continuous Improvement", "foundational"],
  ["Coordination", "foundational"],
  ["Equity", "foundational"],
  ["Expanded Learning", "programmatic"],
  ["Family Engagement & Support", "programmatic"],
  ["Health & Wellness", "programmatic"],
  ["Resource Development", "foundational"],
  ["School Culture & Climate", "programmatic"],
  ["School Readiness & Transitions",  "programmatic"],
  ["Youth leadership", "programmatic"]
]

QualityElement.truncate
quality_elements.each do |name, type|
  qe = QualityElement.new(name: name, element_type: type)
  qe.save
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

regions = [
  "1",
  "2",
  "3",
  "High School"
]

Region.truncate
regions.each do |name|
  r = Region.new(name: name)
  r.save
end

days = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
]

Day.truncate
days.each do |name|
  d = Day.new(name: name)
  d.save
end

ethnicity_culture_groups  = [
  "African American",
  "Asian",
  "Latino",
  "Native American",
  "Pacific Islander",
  "White",
  "English Language Learners",
  "Foster Youth",
  "Homeless Youth",
  "Juvenile Justice/Probation Youth",
  "Special Needs Students"
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
  "Undocumented Students"
]

DemographicGroup.truncate
demographic_groups.each do |name|
  dg = DemographicGroup.new(name: name)
  dg.save
end


grade_levels  = [
  "Pre-Kingergarten",
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
  "Summer"
]

ServiceTime.truncate
service_times.each do |name|
  st = ServiceTime.new(name: name)
  st.save
end

