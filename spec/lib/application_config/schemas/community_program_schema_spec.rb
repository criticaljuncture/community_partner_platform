require 'rails_helper'

RSpec.describe ApplicationConfig::Schemas::CommunityProgramSchema do
  it "each config file conforms to the schema" do
    ApplicationConfig::SUBDOMAINS.each do |subdomain|
      config = YAML.load_file(
        "#{Rails.root}/config/application_config/#{subdomain}/community_program.yml"
      ).deep_symbolize_keys

      result = described_class.new.call(config)

      expect(result.success?).to be(true), "expected true for subdomain '#{subdomain}', got #{result.errors.inspect}"
    end
  end
end
