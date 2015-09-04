class CsvFileImporter < CsvImporter
  attr_accessor :columns,
    :filename,
    :options,
    :table_name

  def initialize(columns, filename, table_name, options={})
    @columns = columns
    @filename = filename
    @options = options
    @table_name = table_name
  end

  def import
    setup_temp_table
    import_to_temp_table
    import_to_table
  end

  def setup_temp_table
    create_temp_table

    CsvFileImport.extend(ActiveRecordDataImport)
  end

  def create_temp_table
    # bring var into scope for temping
    # use all defined columns when creating the temp table even
    # if we don't import them to our final table
    columns_to_import = columns

    ActiveRecord::Base.connection.reconnect!
    # remove reference to table if it's still around so we can use it again
    if Object.constants.include?(:CsvFileImport)
      Object.send(:remove_const, :CsvFileImport)
    end

    Temping.create :csv_file_import do
      with_columns do |t|
        columns_to_import.each do |identifer, config|
          next if config["id"] == 'ID' || config['query']

          options = config["size"] ? {limit: config["size"]} : {}
          t.column config["id"], config["type"].to_sym, options
        end
      end
    end
  end

  # map each column in the csv to a user-defined variable in mysql
  # if there is a mapping we'll use it to do some transformations here
  def csv_column_mappings
    columns.
      each_with_object({}) do |col, hsh|
        if col[1]['mapping']
          hsh["`#{col[1]['id']}`"] = "#{col[1]['mapping']}"
        elsif col[1]['query'].nil?
          hsh["`#{col[1]['id']}`"] = "@'#{col[1]['id']}'"
        end
      end
  end

  def import_to_temp_table
    CsvFileImport.csv_import(
      filename,
      mapping: csv_column_mappings,
      skip_blanks: true,
      headers: true
    )
  end

  def import_to_table
    # map the temp columns to our columns and use the query to transform the
    # data before inserting in our table
    columns_to_import = columns.map do |identifier, config|
      next if config['import'] == false

      if config["query"]
        [identifier, extract_query(config["query"])]
      else
        [identifier, "csv_file_imports.\`#{config['id']}\`"]
      end
    end.compact
    columns_to_import << ['created_at', 'NOW()']
    columns_to_import << ['updated_at', 'NOW()']

    # build the syntax for updating the columns that should be updated on
    # subsequent imports
    duplicate_update_columns = columns.
      reject{|k,v| k == 'id' || v['import'] == false }.
      map{|k,v| k}

    duplicate_update_clause = duplicate_update_columns.
      map{|c| "`#{c}`=VALUES(`#{c}`)"} + ['`updated_at`=NOW()']

    # add the where clause if present
    where_clause = options['where_query'] || ''

    # run any queries we may need to before we perform our import
    # this can be used to build up tmp tables for joins as sub_queries
    # can't reference the same table more than once
    if options['before_import_queries']
      options['before_import_queries'].each do |before_import_query|
        ActiveRecord::Base.connection.execute(
          extract_query(before_import_query)
        )
      end
    end

    # join in any other tables we may need (or created in the before
    # import queries)
    join_clause = options['join_queries'] ? options['join_queries'].join("\n") : ''

    ActiveRecord::Base.connection.execute(<<-SQL)
      INSERT INTO #{table_name}(#{columns_to_import.map{|c| c[0]}.join(',')})
        SELECT #{columns_to_import.map{|c| c[1]}.join(',') }
        FROM csv_file_imports
        #{join_clause}
        #{where_clause}
      ON DUPLICATE KEY UPDATE #{duplicate_update_clause.join(',')}
    SQL

    if options['after_import_queries']
      options['after_import_queries'].each do |after_import_query|
        ActiveRecord::Base.connection.execute(
          extract_query(after_import_query)
        )
      end
    end
  end

  private

  # the query may actually be a method name, if so we call it or
  # otherwise return the query
  def extract_query(query)
    return unless query

    if match = query.match(/^%{(.*?)}$/) # in the form %{some_method_name}
      eval(match[1])
    else
      query
    end
  end
end
