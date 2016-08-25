require 'spec_helper'

describe Organization do

  context "#update_completion_rate" do
    it "calculates correctly (on save)" do
      organization = Organization.create(
        name: "Foo Organization",
        address: "123 Street",
        legal_status_id: 1
      )

      expect(organization.completion_rate).to eq(25.0)

      organization.zip_code = "12345"
      organization.save(validate: false)
      organization.reload

      expect(organization.completion_rate).to eq(33.3333)
    end
  end

end
