class CompletionPolicy::Base
  attr_accessor :model

  delegate :completion_rate,
    :missing_fields,
    to: :model

  def initialize(model=nil)
    @model = model
  end

  def completion_weights
    app_config.completion_policy.weights.map do |weight|
      value, fields = weight.value, weight.fields
      fields = fields == :required_fields ? model.required_fields : fields

      [value, fields]
    end
  end

  def before_save(record)
    # set the model that was passed as nil (callback is created in a class context)
    @model = record

    update_completion_rate(record)
    update_missing_fields(record)
  end

  private

  def completion_rate_calculator
    CompletionRateCalculator.new(
      model,
      completion_weights
    )
  end

  def update_completion_rate(record)
    record.completion_rate = completion_rate_calculator.completion_rate
  end

  def update_missing_fields(record)
    record.missing_fields = completion_rate_calculator.missing_fields
  end

  def app_config
    @app_config ||= Settings.app_config.send(model.class.name.underscore)
  end
end
