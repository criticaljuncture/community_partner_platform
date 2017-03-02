require 'rails_helper'

RSpec.describe Organization do
  it "includes the ApplicationConfig::Validations module" do
    expect(Organization.included_modules)
      .to include(ApplicationConfig::Validations)
  end

  context "before_save callbacks" do
    let(:organization) { build(:organization) }

    it "calls the completion_policy #before_save method" do
      expect(
        CompletionPolicy::OrganizationPolicy
      ).to receive(:before_save).with(organization)

      organization.run_callbacks(:save){ false } #onlt run before callbacls
    end
  end
end
