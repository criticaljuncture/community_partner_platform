namespace :sps do
  namespace :import do
    task :school_programs => :environment do
      require 'csv'

      CSV.foreach("#{Rails.root}/data/CSV/SPS_SchoolPrograms.csv", :headers => true) do |row|
        site_code = row["school_code"]
        school = School.find_by(site_code: site_code)

        program_name = row["program_name"]
        community_program = CommunityProgram.find_by(name: program_name)

        unless school && community_program
          puts "can't find #{site_code} or #{program_name}"
          next
        end

        school_program = SchoolProgram.new(
          school_id: school.id,
          community_program_id: community_program.id
        )

        school_program.save(validate: false)
      end
    end
  end
end
