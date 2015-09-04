module ActiveRecordDataImport
  def csv_import(csv_path, options)
    options.reverse_merge!(
      fields_terminated_by: ','
    )

    file_import(csv_path, options)
  end

  private

  def file_import(csv_path, options)
    csv = CSV.open(csv_path, options.delete(:csv_options))
    columns = csv.readline
    csv.close

    options[:columns] ||= columns.map{|c| "@'#{c}'"}

    options.reverse_merge!(
      ignore_lines: 1,
      lines_terminated_by: csv.row_sep,
      fields_optionally_enclosed_by: '"'
    )
    fast_import(csv_path, options)
  end
end
