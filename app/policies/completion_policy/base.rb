class CompletionPolicy::Base
  attr_accessor :model

  delegate :completion_rate,
    :missing_fields,
    to: :model

  def initialize(model)
    @model = model
  end

  def completion_weights
    app_config.completion_policy.weights.map do |weight|
      value, fields = weight.value, weight.fields
      fields = fields.first == :required_fields ? model.required_fields : fields

      [value, fields]
    end
  end

  def self.before_save(record)
    new(record).before_save
  end

  def before_save
    update_completion_rate
    update_missing_fields
  end

  private

  def completion_rate_calculator
    CompletionRateCalculator.new(
      model,
      completion_weights
    )
  end

  def update_completion_rate
    model.completion_rate = completion_rate_calculator.completion_rate
  end

  def update_missing_fields
    model.missing_fields = completion_rate_calculator.missing_fields
  end

  def app_config
    @app_config ||= Settings.app_config.send(model.class.name.underscore)
  end
end
