class CommunityProgramImporter < CsvFileImporter
  def self.perform(config, filename)
    new(
      config['columns'],
      filename,
      'community_programs',
      config['options'] || {}
    ).import
  end
end
