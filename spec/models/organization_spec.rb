require 'spec_helper'

describe Organization do

  context "#update_program_completion_rate" do
    it "calculates correctly" do
      organization = Organization.create(
        name: "Foo Organization",
        legal_status_id: 1
      )

      result = organization.program_completion_rate

      expect(result).to eq(50.0)
    end
  end

end