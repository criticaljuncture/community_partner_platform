Formtastic::Helpers::FormHelper.builder = FormtasticBootstrap::FormBuilder

module Formtastic
  module Inputs
    class SelectInput
      def multiple_with_options_fix?
        return false if options[:multiple] === false
        multiple_without_options_fix?
      end

      alias_method_chain :multiple?, :options_fix
    end
  end
end
