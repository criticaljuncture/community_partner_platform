module ApplicationConfig
  module Schemas
    class CommunityProgramSchema < BaseSchema
      schema do
        required(:app_config).hash do
          required(:community_program).hash do
            required(:completion_policy).hash do
              required(:weights).filled(min_size?: 1)
              required(:weights).array(:hash) do
                required(:value).value(:float)
                required(:fields).each(:symbol)
              end
            end

            required(:public_policy).hash do
              required(:percentage_complete).value(:float)
              required(:public_attributes).each(:symbol)
              required(:required_attributes).each(:symbol)
              required(:verification_required).value(:bool)
            end

            required(:validations).array(:hash) do
              required(:attribute).value(:symbol)
              required(:options).hash do
                required(:presence) { bool? | hash? }
              end
            end

            required(:verification_policy).hash do
              required(:verification_date).value(:string)
              required(:grace_period_end_date).value(:string)
            end
          end
        end
      end

      rule(
        "app_config.community_program.verification_policy.verification_date"
      ).validate(:iso_string)

      rule(
        "app_config.community_program.verification_policy.grace_period_end_date"
      ).validate(:iso_string)
    end
  end
end
