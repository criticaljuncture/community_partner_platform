require 'rails_helper'

RSpec.describe "CompletionPolicy::Base" do
  let(:model) { build(:organization) }
  let(:policy) { CompletionPolicy::Base.new(model) }

  describe "#initialize" do
    it "accepts a model and sets a reader for it" do
      expect(policy.model).to be(model)
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

  it ".before_save calls new with the given record" do
    model = build(:organization)

    expect(CompletionPolicy::Base).to receive(:new).with(model).and_call_original
    CompletionPolicy::Base.before_save(model)
  end

  context "#before_save" do
    let(:model) { build(:organization) }
    let(:policy) { CompletionPolicy::Base.new(model) }

    it "updates the completion rate" do
      policy.before_save

      model.zip_code = "94107"
      expect{
        policy.before_save
      }.to change{ model.completion_rate }
    end

    it "updates the missing_fields" do
      policy.before_save
      fields = model.missing_fields

      model.zip_code = "94107"
      policy.before_save
      expect(model.missing_fields).to eq(fields - ["zip_code"])
    end
  end
end
