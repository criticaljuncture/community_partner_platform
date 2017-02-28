require 'rails_helper'

RSpec.describe "CompletionPolicy::Base" do
  let(:model) { build(:organization) }
  let(:policy) { CompletionPolicy::Base.new(model) }

  describe "#initialize" do
    it "accepts a model and sets a reader for it" do
      expect(policy.model).to be(model)
    end

    # used for before_save callback
    it "allows new with no arguments" do
      expect(CompletionPolicy::Base.new.model).to be nil
    end
  end

  it "responds to methods that were delegated" do
    expect(policy).to respond_to(:completion_rate)
    expect(policy).to respond_to(:missing_fields)
  end

  it "#completion_weights returns the weights from app_config" do
    expect(policy.completion_weights).to eq(
      [[0.25, [:name, :legal_status_id]], [0.75,[:address, :zip_code]]]
    )
  end

  context "#before_save" do
    let(:record) { build(:organization) }
    let(:policy) { CompletionPolicy::Base.new }

    it "sets model to the record" do
      expect(policy.model).to be nil
      policy.before_save(record)
      expect(policy.model).to be(record)
    end

    it "updates the completion rate" do
      policy.before_save(model)

      model.zip_code = "94107"
      expect{
        policy.before_save(model)
      }.to change{ model.completion_rate }
    end

    it "updates the missing_fields" do
      policy.before_save(model)
      fields = model.missing_fields

      model.zip_code = "94107"
      policy.before_save(model)
      expect(model.missing_fields).to eq(fields - ["zip_code"])
    end
  end
end
