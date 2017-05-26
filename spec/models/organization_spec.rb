require 'rails_helper'

RSpec.describe Organization do
  let(:organization) { build(:organization) }

  it "includes the ApplicationConfig::Validations module" do
    expect(Organization.included_modules)
      .to include(ApplicationConfig::Validations)
  end

  it "calls the completion policy #before_save method" do
    expect(
      CompletionPolicy::OrganizationPolicy
    ).to receive(:before_save).with(organization)

    organization.run_callbacks(:save){ false } #onlt run before callbacls
  end

  it "#completion_policy returns an instance of the proper completion_policy" do
    expect(organization.completion_policy)
      .to be_an_instance_of CompletionPolicy::OrganizationPolicy
  end

  it "#public_policy returns an instance of the proper public_policy" do
    expect(organization.public_policy)
      .to be_an_instance_of PublicPolicy::OrganizationPolicy
  end
end
