require 'rails_helper'

RSpec.describe CommunityProgram do
  let(:community_program) { build(:community_program) }

  it "includes the ApplicationConfig::Validations module" do
    expect(CommunityProgram.included_modules)
      .to include(ApplicationConfig::Validations)
  end

  it "calls the completion_policy #before_save method" do
    expect(
      CompletionPolicy::CommunityProgramPolicy
    ).to receive(:before_save).with(community_program)

    community_program.run_callbacks(:save){ false } #onlt run before callbacls
  end

  it "#completion_policy returns an instance of the proper completion_policy" do
    expect(community_program.completion_policy)
      .to be_an_instance_of CompletionPolicy::CommunityProgramPolicy
  end
end
