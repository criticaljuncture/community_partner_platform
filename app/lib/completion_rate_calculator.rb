class CompletionRateCalculator
  attr_private :object, :weights

  def initialize(object, weights)
    @object  = object
    @weights = weights
  end

  def completion_rate
    rate = weights.inject(0) do |total_sum, allocation|
      weight     = allocation[0]
      attributes = allocation[1]

      attributes.each do |attribute|
        if has_value?(attribute)
          total_sum += attribute_weighting(weight, attributes)
        end
      end

      total_sum
    end

    rate * 100
  end

  def missing_fields
    weights.map do |weight, attributes|
      attributes.reject do |attribute|
        has_value?(attribute)
      end
    end.flatten
  end

  private

  def attribute_weighting(weight, attributes)
    weight.to_f / attributes.size
  end

  def has_value?(attribute)
    object.send(attribute).present?
  end
end
