class ProgramCompletionRateCalculator

  def initialize(entity, weights)
    @entity  = entity
    @weights = weights
  end

  def completion_rate
    rate = weights.inject(0) do |total_sum, allocation|
      weight     = allocation[0]
      attributes = allocation[1]

      attribute_weighting = weight.to_f / attributes.size

      attributes.each do |attribute|
        if entity.send(attribute).present?
          total_sum += attribute_weighting
        end
      end

      total_sum
    end

    rate * 100
  end

  private

  attr_reader :entity, :weights

end