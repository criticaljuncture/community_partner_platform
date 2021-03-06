require 'rails_helper'

RSpec.describe "CompletionRateCalculator" do
  let(:organization) { build(:organization) }

  describe "#completion_rate" do
    it "calculates rates correctly with a single rate" do
      calculator = CompletionRateCalculator.new(
        organization,
        [
          [1.0, [:name, :url]],
        ]
      )

      expect(calculator.completion_rate).to eq(50.0)
    end

    it "calculates multiple rates correctly when two rates are the same" do
      calculator = CompletionRateCalculator.new(
        organization,
        [
          [0.5, [:name, :url]],
          [0.5, [:address]],
        ]
      )

      expect(calculator.completion_rate).to eq(25.0)
    end

    it "calculates multiple rates correctly when two rates are different" do
      calculator = CompletionRateCalculator.new(
        organization,
        [
          [0.6, [:name, :url]],
          [0.4, [:address]],
        ]
      )

      expect(calculator.completion_rate).to eq(30.0)
    end
  end

  describe "#missing_fields" do
    it "returns the missing fields that lower a completion rate from 100%" do
      calculator = CompletionRateCalculator.new(
        organization,
        [
          [0.6, [:name, :url]],
          [0.4, [:address]],
        ]
      )

      expect(calculator.missing_fields).to eq([:url, :address])
    end
  end
end
