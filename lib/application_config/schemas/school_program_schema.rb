class ApplicationConfig::Schemas::SchoolProgramSchema < ApplicationConfig::Schemas::BaseSchema
  define! do
    required("app_config").schema do
      required("school_program").schema do
        required("validations").each do
          required("attribute").value(:symbol?)
          required("options").schema do
            required("presence").value(:boolean_or_hash?)
          end
        end
      end
    end
  end
end
