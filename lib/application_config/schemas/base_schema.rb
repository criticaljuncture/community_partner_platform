class ApplicationConfig::Schemas::BaseSchema < Dry::Validation::Schema
  configure do
    def symbol?(value)
      value.is_a?(Symbol)
    end

    def bool_or_hash?(value)
      [true, false].include?(value) || value.is_a?(Hash)
    end
  end
end
