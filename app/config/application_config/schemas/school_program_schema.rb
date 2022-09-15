module ApplicationConfig
  module Schemas
    class SchoolProgramSchema < BaseSchema
      schema do
        required(:app_config).hash do
          required(:school_program).hash do
            required(:validations).array(:hash) do
              required(:attribute).value(:symbol)
              required(:options).hash do
                required(:presence) { bool? | hash? }
              end
            end
          end
        end
      end
    end
  end
end
