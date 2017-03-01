require 'spec_helper'

RSpec.describe ApplicationConfig::Schemas::OrganizationSchema do
  let(:schema) {
    Dry::Validation.Schema(
      ApplicationConfig::Schemas::OrganizationSchema
    )
  }

  it "each config file conforms to the schema" do
    ApplicationConfig::SUBDOMAINS.each do |subdomain|
      config = YAML.load_file(
        "#{Rails.root}/config/application_config/#{subdomain}/organization.yml"
      )

      result = schema.call(config)

      expect(result.success?).to be(true), "expected true for subdomain '#{subdomain}', got #{result.errors}"
    end
  end
end
