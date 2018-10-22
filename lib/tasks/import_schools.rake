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
end
