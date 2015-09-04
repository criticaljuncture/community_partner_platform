class CsvImporter
  require 'csv'

  def each_row(file_path, options, &block)
    CSV.open(file_path, options).each do |row|
      yield row
    end
  end

  def log(message)
    puts message
    Rails.logger.debug message
  end
end
