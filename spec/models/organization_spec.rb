require 'spec_helper'

describe Organization do
  let(:organization) do
    Organization.create(
      name: "Foo Organization",
      address: "123 Street",
      legal_status_id: 1
    )
  end

  context "#update_completion_rate" do
    it "calculates correctly (on save)" do
      expect(organization.completion_rate).to eq(25.0)

      organization.zip_code = "12345"
      organization.save(validate: false)

      expect(organization.completion_rate).to eq(33.33333333333333)
      organization.reload
      expect(organization.completion_rate).to eq(33.3333)
    end
  end

  context "#update_missing_fields" do
    it "calculates correctly (on save)" do
      expect(organization.missing_fields).to eq(["city", "zip_code", "phone_number", "url", "mou_on_file", "mission_statement", "services_description", "program_impact", "cost_per_student"])

      organization.zip_code = "12345"
      organization.save(validate: false)

      expect(organization.missing_fields).to eq(["city", "phone_number", "url", "mou_on_file", "mission_statement", "services_description", "program_impact", "cost_per_student"])
    end
  end
end
