require 'rails_helper'

RSpec.describe Organization do
  # uses settings in config/app_config/test.yml
  context "validations from app configuration" do
    it "properly sets them for `presence` type validations" do
      org = build(:organization, name: nil)
      expect(org).not_to be_valid

      org.name = 'Test Org'
      expect(org).to be_valid
    end

    it "properly sets the error message when provided" do
      org = build(:organization, legal_status_id: nil)
      expect(org).not_to be_valid
      expect(
        org.errors.messages[:legal_status_id]
      ).to eq(['Please choose from the list above'])

      org.legal_status_id = 1
      expect(org).to be_valid
    end
  end

  context "saving an organization" do
    let(:organization) { build(:organization) }

    it "calls the completion_policy #before_save method" do
      expect_any_instance_of(
        CompletionPolicy::OrganizationPolicy
      ).to receive(:before_save).with(organization)

      organization.save(validate: false)
    end
  end
end
