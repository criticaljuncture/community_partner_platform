module SimpleForm
  module Components
    module Public
      def public(wrapper_options = nil)
        return public_component if options[:public]
      end

      def public_component
        public_tag = template.content_tag(:span, '', class: 'icon-cpp icon-cpp-globe')
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Public)
