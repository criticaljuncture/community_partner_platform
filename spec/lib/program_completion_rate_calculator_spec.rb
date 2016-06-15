require 'spec_helper'

describe "ProgramCompletionRateCalculator" do

  describe "#completion_rate" do

    it "calculates rates correctly with a single rate" do
      organization = double
      organization.stub(:name).and_return("Test Org")
      organization.stub(:location)

      calculator = ProgramCompletionRateCalculator.new(
        organization,
        [
          [1.0, [:name, :location]],
        ]
      )

      expect(calculator.completion_rate).to eq(0.5)
    end

    it "calculates multiple rates correctly when two rates are the same" do
      organization = double
      organization.stub(:name).and_return("Test Org")
      organization.stub(:city).and_return([])
      organization.stub(:location)
      organization.stub(:address)

      calculator = ProgramCompletionRateCalculator.new(
        organization,
        [
          [0.5, [:name, :location]],
          [0.5, [:city, :address]],
        ]
      )

      expect(calculator.completion_rate).to eq(0.25)
    end
  end
end
