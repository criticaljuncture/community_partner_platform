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

      attribute_weighting = weight.to_f / attributes.size

      attributes.each do |attribute|
        if object.send(attribute).present?
          total_sum += attribute_weighting
        end
      end

      total_sum
    end

    rate * 100
  end
end
