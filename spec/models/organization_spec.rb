require 'spec_helper'

describe Organization do

  context "#update_completion_rate" do
    it "calculates correctly" do
      organization = Organization.create(
        name: "Foo Organization",
        address: "123 Street",
        legal_status_id: 1
      )

      result = organization.program_completion_rate

      expect(result).to eq(25.0)
    end
  end

end
