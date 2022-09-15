module ApplicationConfig
  module Schemas
    class BaseSchema < Dry::Validation::Contract
      register_macro(:iso_string) do
        unless /\d{4}-\d{2}-\d{2}/.match?(value)
          key.failure('must be an ISO formatted date, YYYY-MM-DD')
        end
      end
    end
  end
end
