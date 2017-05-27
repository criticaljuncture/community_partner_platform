require 'rails_helper'

RSpec.describe "PublicPolicy::Base" do
  let(:model) { double("Organization") }
  let(:policy) { PublicPolicy::Base.new(model) }

  describe ".policy_for" do
    it "accepts a type and sets a class level variable" do
      policy.class.policy_for :organization
      expect(policy.class.policy_model).to eq('organization')
    end
  end

  describe "#initialize" do
    it "accepts a model and sets a reader for it" do
      expect(policy.model).to be(model)
    end
  end

  it "#public_attributes returns the attributes that will be shown in the public view" do
    model = build(:organization)
    policy = PublicPolicy::Base.new(model)
    policy.class.policy_for :organization

    expect(policy.public_attributes).to eq([:name, :mission_statement])
  end

  it "#required_attributes returns the attributes required to be public from the application config" do
    model = build(:organization)
    policy = PublicPolicy::Base.new(model)
    policy.class.policy_for :organization

    expect(policy.required_attributes).to eq([:name, :mou_on_file])
  end

  describe "#required_attributes_present?" do
    before(:each) {
      allow(policy).to receive(:required_attributes)
        .and_return([:name, :mou_on_file])
    }

    it "returns true if all required attributes are present" do
      allow(model).to receive(:name).and_return('Organization 1')
      allow(model).to receive(:mou_on_file).and_return(true)

      expect(policy.required_attributes_present?).to be(true)
    end

    it "returns false if any required attributes is not present" do
      allow(model).to receive(:name).and_return('Organization 1')
      allow(model).to receive(:mou_on_file).and_return(nil)

      expect(policy.required_attributes_present?).to be(false)
    end
  end

  describe "#minimally_complete?" do
    before(:each) {
      allow(policy).to receive(:minimum_completion_percentage)
        .and_return(0.25)
    }

    it "returns true if model completion is greater than the minimum" do
      allow(model).to receive(:completion_rate).and_return(75)
      expect(policy.minimally_complete?).to be(true)
    end

    it "returns true if model completion is equal to the minimum" do
      allow(model).to receive(:completion_rate).and_return(25)
      expect(policy.minimally_complete?).to be(true)
    end

    it "returns false if model completion is less than the minimum" do
      allow(model).to receive(:completion_rate).and_return(15)
      expect(policy.minimally_complete?).to be(false)
    end
  end

  describe "#verification_required?" do
    context "verification is configured as required" do
      before(:each) do
        allow(policy).to receive(:policy_config).and_return(
          OpenStruct.new(verification_required: true)
        )
      end

      it "returns true if the model needs verification" do
        allow(model).to receive(:verification_required?).and_return(true)
        expect(policy.verification_required?).to be(true)
      end

      it "returns false if the model has been verified" do
        allow(model).to receive(:verification_required?).and_return(false)
        expect(policy.verification_required?).to be(false)
      end
    end

    context "verification is not configured as required" do
      it "returns false" do
        allow(policy).to receive(:policy_config).and_return(
          OpenStruct.new(verification_required: false)
        )
        expect(policy.verification_required?).to be(false)
      end
    end
  end

  describe "#can_be_made_public?" do
    # we convert NAT to true and NAF to false in the tests
    # but use these when we are not explicitely testing that condition
    # eg. it's a precondition for what we want to actually test
    possible_states = <<-TEXT
      |---------------------+-----------------------------+--------------------+-----------------------+--------------------|
      | approved_for_public | required_attributes_present | minimally_complete | verification_required | can_be_made_public |
      |---------------------+-----------------------------+--------------------+-----------------------+--------------------|
      |        true         |            NAT              |        NAT         |          NAF          |        false       |
      |        false        |            NAT              |        NAT         |          NAF          |        true        |
      |        NAF          |            true             |        NAT         |          NAF          |        true        |
      |        NAF          |            false            |        NAT         |          NAF          |        false       |
      |        NAF          |            NAT              |        true        |          NAF          |        true        |
      |        NAF          |            NAT              |        false       |          NAF          |        false       |
      |        NAF          |            NAT              |        NAT         |          true         |        false       |
      |        NAF          |            NAT              |        NAT         |          false        |        true        |
      |---------------------+-----------------------------+--------------------+-----------------------+--------------------|
    TEXT

    # dynamically generate a test for each possible state our model/policy can be in
    ATV.from_string(possible_states).each do |state|
      state.to_hash.each{|k,v| state[k] = true if v == "NAT"}.each{|k,v| state[k] = false if v == "NAF"}

      it "returns #{state['can_be_made_public']} when approved_for_public? is #{state['approved_for_public']} \
      and required_attributes_present? is #{state['required_attributes_present']} \
      and minimally_complete? is #{state['minimally_complete']}\
      and verification_required? is #{state['verification_required']}" do
        allow(model).to receive(:approved_for_public?).and_return(state['approved_for_public'])
        allow(policy).to receive(:required_attributes_present?).and_return(state['required_attributes_present'])
        allow(policy).to receive(:minimally_complete?).and_return(state['minimally_complete'])
        allow(policy).to receive(:verification_required?).and_return(state['verification_required'])

        expect(policy.can_be_made_public?).to be(state['can_be_made_public'])
      end
    end
  end

  describe '#missing_requirements' do
    it "includes the proper messsage when required_attributes are missing" do
      allow(policy).to receive(:required_attributes_present?).and_return(false)
      allow(policy).to receive(:minimally_complete?).and_return(true)

      message = I18n.t(
        'public_policy.missing_requirements.required_attributes'
      )

      expect(policy.missing_requirements).to include(message)
    end

    it "includes the proper messsage when the record is not minimally_complete" do
      allow(policy).to receive(:required_attributes_present?).and_return(true)
      allow(policy).to receive(:minimally_complete?).and_return(false)

      message = I18n.t(
        'public_policy.missing_requirements.minimally_complete',
        percentage: policy.minimum_completion_percentage * 100
      )

      expect(policy.missing_requirements).to include(message)
    end
  end
end
