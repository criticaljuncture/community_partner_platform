class SchoolImporter < CsvFileImporter
  def self.perform(config, filename)
    new(
      config['columns'],
      filename,
      'schools',
      config['options'] || {}
    ).import
  end
end
