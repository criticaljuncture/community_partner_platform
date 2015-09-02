module RecordDisplayHelper
  def columnar_table_block(header, options={}, &block)
    table = options.fetch(:auto_table) { true }

    wrapper_class = options.fetch(:class) { nil }
    columns = options.fetch(:columns) { {xs: 12, md: 6} }

    wrapper_class = [
      bootstrap_col(columns),
      'columnar-table-block',
      wrapper_class
    ].compact.join(' ')

    render partial: 'record_display/columnar_table', locals: {
      content: capture(&block),
      header: header,
      table: table,
      wrapper_class: wrapper_class
    }
  end

  def columnar_table(content=nil, options={}, &block)
    content = content.nil? ? capture(&block) : content

    table_class = options.fetch(:class){ '' }
    table_id = options.fetch(:id){ '' }

    content_tag(:table, id: table_id,
      class: "table table-condensed #{table_class}") do
      content_tag(:tbody, content)
    end
  end
end
