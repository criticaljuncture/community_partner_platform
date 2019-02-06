class OrganizationImporter < CsvFileImporter
  def self.perform(config, filename)
    new(
      config['columns'],
      filename,
      'organizations',
      config['options'] || {}
    ).import
  end
end
