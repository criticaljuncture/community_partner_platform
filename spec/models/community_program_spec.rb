require 'rails_helper'

RSpec.describe CommunityProgram do
  it "includes the ApplicationConfig::Validations module" do
    expect(CommunityProgram.included_modules)
      .to include(ApplicationConfig::Validations)
  end

  context "before_save callbacks" do
    let(:community_program) { build(:community_program) }

    it "calls the completion_policy #before_save method" do
      expect(
        CompletionPolicy::CommunityProgramPolicy
      ).to receive(:before_save).with(community_program)

      community_program.run_callbacks(:save){ false } #onlt run before callbacls
    end
  end
end
