require 'rails_helper'

RSpec.describe Organization do
  let(:organization) { create(:organization) }
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
