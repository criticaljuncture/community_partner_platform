class ColumizedCheckboxesInput < SimpleForm::Inputs::CollectionCheckBoxesInput
  def input(wrapper_options = nil)
    label_method, value_method = detect_collection_methods

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    columns = input_options[:columns]
    raise "You must provide a number of columns! eg. {columns: 3}" unless columns

    column_html = input_options[:column_html] || {class: 'col-md-4'}
    choice_groups = []
    
    if collection.present?
      groups_of = (collection.length.to_f / columns).ceil

      collection.in_groups_of(groups_of, false) do |choices|
        html = ["<div class='checkbox-column #{column_html[:class]}'>"]

        html << @builder.send(:"collection_check_boxes",
          attribute_name, choices, value_method, label_method,
          input_options, merged_input_options,
          &collection_block_for_nested_boolean_style
        )

        html << "</div>"
        choice_groups << html.join("\n").html_safe
      end
    end

    choice_groups.join("\n").html_safe
  end
end
