require 'rails_helper'

RSpec.describe Organization do
  let(:organization) { create(:organization) }

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

  context "#update_completion_rate" do
    it "calculates correctly (on save)" do
      expect(organization.completion_rate).to eq(25.0)

      organization.zip_code = "12345"
      organization.save(validate: false)

      expect(organization.completion_rate).to eq(32.5)
      organization.reload
      expect(organization.completion_rate).to eq(32.5)
    end
  end

  context "#update_missing_fields" do
    it "calculates correctly (on save)" do
      fields = ["address", "city", "zip_code", "phone_number", "url",
        "mou_on_file", "mission_statement", "services_description",
        "program_impact", "cost_per_student"]

      expect(organization.missing_fields).to eq(fields)

      organization.zip_code = "12345"
      organization.save(validate: false)

      expect(organization.missing_fields).to eq(fields-["zip_code"])
    end
  end
end
