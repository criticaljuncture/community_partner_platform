module ColumnarTableHelper
  def columnar_attributes_display(header:, model:, attrs:, only_public_attrs:, options:{})
    attrs = only_public_attrs ? attrs.select{|attr| model.send(:public_attribute?, attr) } : attrs

    return '' unless attrs.present?

    columnar_table_block(header, options) do
      attrs.each do |attr|
        concat columnar_attribute_display(model, attr)
      end
    end
  end

  def columnar_attribute_display(model, attr)
    content_tag(:tr) do
      content_tag(:td) do
        I18n.t("#{model.class.table_name}.#{attr.to_s.gsub('?', '')}")
      end +
      content_tag(:td) do
        default_value_for(model, attr)
      end
    end
  end

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
    return "" unless content || block_given?
    content = content.nil? ? capture(&block) : content

    table_class = options.fetch(:class){ '' }
    table_id = options.fetch(:id){ '' }

    content_tag(:table, id: table_id,
      class: "table table-condensed #{table_class}") do
      content_tag(:tbody, content)
    end
  end

  def columnar_table_body(content=nil, options={}, &block)
    content = content.nil? ? capture(&block) : content
    content_tag(:tbody, content)
  end
end
