class ColumizedCheckboxesInput < FormtasticBootstrap::Inputs::CheckBoxesInput
  include FormtasticBootstrap::Inputs::Base
  include FormtasticBootstrap::Inputs::Base::Choices

  def to_html
    choice_groups = []

    raise "You must provide a number of columns! eg. {columns: 3}" unless input_options[:columns]

    groups_of = (collection.length.to_f / input_options[:columns]).ceil

    collection.in_groups_of(groups_of, false) do |choices|
      html = ["<div class='checkbox-column'>"]
      html << choices.map do |choice|
                choice_html(choice)
              end.join("\n").html_safe
      html << "</div>"
      choice_groups << html.join("\n").html_safe
    end

    control_group_wrapping do
      control_label_html <<
      hidden_field_for_all <<
      controls_wrapping do
        choice_groups.join("\n").html_safe
      end
    end
  end
end
