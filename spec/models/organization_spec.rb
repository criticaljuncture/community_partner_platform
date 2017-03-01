require 'rails_helper'

RSpec.describe Organization do
  it "includes the ApplicationConfig::Validations module" do
    expect(Organization.included_modules)
      .to include(ApplicationConfig::Validations)
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
