module ApplicationConfig::Validations
  def self.included(klass)
    verify_app_config!(klass)

    klass.class_eval do
      Settings.app_config.send("#{klass.name.underscore}").validations.each do |config|
        validates config.attribute, config.options.to_hash
      end
    end
  end

  def required_fields
    @required_fields ||= Settings.app_config.send("#{self.class.name.underscore}").validations.select do |config|
      config.options.any?{|k,v| k = :presence}
    end.map(&:attribute)
  end

  private

  def self.verify_app_config!(klass)
    app_config = Settings.app_config.send("#{klass.name.underscore}")
    unless app_config.present? && !app_config.validations.nil?
      raise "Missing app config or validation key for #{klass}"
    end
  end
end
