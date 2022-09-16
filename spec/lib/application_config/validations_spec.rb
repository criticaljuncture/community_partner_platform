require 'rails_helper'

module ApplicationConfig
  class ValidationTest < Struct.new(:favorite_color, :name)
    include ActiveModel::Validations
    include ApplicationConfig::Validations
  end
end

RSpec.describe ApplicationConfig::Validations do
  let(:model) {
    ApplicationConfig::ValidationTest.new(
      'blue, no yellow',
      'Test'
    )
  }

  context "validations from app configuration" do
    it "properly sets them for `presence` type validations" do
      model.name = nil
      expect(model).not_to be_valid

      model.name = 'Test'
      expect(model).to be_valid
    end

    it "properly sets the error message when provided" do
      model.favorite_color = nil
      expect(model).not_to be_valid
      expect(
        model.errors.messages[:favorite_color]
      ).to eq(['Please choose from the list above'])

      model.favorite_color = 'blue, no yellow'
      expect(model).to be_valid
    end
  end
end
