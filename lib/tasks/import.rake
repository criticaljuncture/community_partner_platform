namespace :import do
  task :schools, [:filename] => :environment do |t, args|
    config = YAML.load_file(
      File.join(
        Rails.root, 'data', 'csv_file_importer_config',
        Settings.application.subdomain, 'schools.yml'
      )
    )

    SchoolImporter.perform(config["schools"], args.filename)
  end

  task :organizations, [:filename] => :environment do |t, args|
    config = YAML.load_file(
      File.join(
        Rails.root, 'data', 'csv_file_importer_config',
        Settings.application.subdomain, 'organizations.yml'
      )
    )

    OrganizationImporter.perform(config["organizations"], args.filename)
  end

  task :community_programs, [:filename] => :environment do |t, args|
    config = YAML.load_file(
      File.join(
        Rails.root, 'data', 'csv_file_importer_config',
        Settings.application.subdomain, 'community_programs.yml'
      )
    )

    CommunityProgramImporter.perform(config["community_programs"], args.filename)
  end

  task :school_programs, [:filename] => :environment do |t, args|
    config = YAML.load_file(
      File.join(
        Rails.root, 'data', 'csv_file_importer_config',
        Settings.application.subdomain, 'school_programs.yml'
      )
    )

    CommunityProgramImporter.perform(config["school_programs"], args.filename)
  end
end
