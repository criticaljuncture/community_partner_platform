class ApplicationConfig::Schemas::BaseSchema < Dry::Validation::Schema
  def self.messages
    Dry::Validation::Messages.default.merge(
      en: {errors: {
        boolean_or_hash?: 'must be a boolean or a hash',
        boolean?: 'must be true or false',
        symbol?: 'must be a symbol',
      }}
    )
  end

  configure do
    def boolean?(value)
      [true, false].include?(value)
    end

    def boolean_or_hash?(value)
       boolean?(value) || value.is_a?(Hash)
    end

    def symbol?(value)
      value.is_a?(Symbol)
    end
  end
end
