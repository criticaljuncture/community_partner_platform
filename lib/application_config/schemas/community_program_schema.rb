class ApplicationConfig::Schemas::CommunityProgramSchema < ApplicationConfig::Schemas::BaseSchema
  define! do
    required("app_config").schema do
      required("community_program").schema do
        required("completion_policy").schema do
          required("weights").filled(min_size?: 1)
          required("weights").each do
            required("value").value(:float?)
            required("fields").each(:symbol?)
          end
        end

        required("public_policy").schema do
          required("percentage_complete").value(:float?)
          required("public_attributes").each(:symbol?)
          required("required_attributes").each(:symbol?)
          required("verification_required").value(:boolean?)
        end

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
