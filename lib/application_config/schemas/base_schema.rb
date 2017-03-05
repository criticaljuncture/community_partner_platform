class ApplicationConfig::Schemas::BaseSchema < Dry::Validation::Schema
  def self.messages
    Dry::Validation::Messages.default.merge(
      en: {errors: {
        symbol?: 'must be a symbol',
        bool_or_hash?: 'must be a boolean or a hash'
      }}
    )
  end

  configure do
    def symbol?(value)
      value.is_a?(Symbol)
    end

    def bool_or_hash?(value)
      [true, false].include?(value) || value.is_a?(Hash)
    end
  end
end
