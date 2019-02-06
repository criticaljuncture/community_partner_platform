class SchoolProgramImporter < CsvFileImporter
  def self.perform(config, filename)
    new(
      config['columns'],
      filename,
      'school_programs',
      config['options'] || {}
    ).import
  end
end
