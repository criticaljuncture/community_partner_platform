namespace :move do
  namespace :programs do
    task :ousd => :environment do
      #program_name, #organization_name
      remaps = [
        ["Tobacco Use Prevention Education", "OUSD - Health Services: Tobacco Use Prevention Education"],
        ["School Nurse", "OUSD - Health Services: School Nurses"],
        ["Manhood Development Program", "OUSD - African American Male Achievement"],
        ["Linked Learning", "OUSD - Linked Learning"],
        ["Community School Manager", "OUSD - Community Partnerships"],
        ["Restorative Justice and/or Practice", "OUSD - Behaviorial Health: Restorative Justice"],
        ["Mental Health, Behaviorial Health or PBIS, or School Psychologist", "OUSD - Behaviorial Health"],
        ["After School Lead", "OUSD - After School Program Office"],
        ["Resource Specialist", "OUSD - Special Education"],
      ]

      remaps.each do |program_name, organization_name|
        org = Organization.find_or_create_by(name: organization_name)

        CommunityProgram.where(name: program_name).each do |program|
          org.community_programs << program unless org.community_programs.include?(program)
        end
      end
    end
  end
end
