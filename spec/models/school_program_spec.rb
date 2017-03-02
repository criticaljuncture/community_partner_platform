require 'rails_helper'

RSpec.describe SchoolProgram do
  let(:school_program) { build(:school_program) }

  it "includes the ApplicationConfig::Validations module" do
    expect(SchoolProgram.included_modules)
      .to include(ApplicationConfig::Validations)
  end

  it "calls the completion policy #before_save method" do
    expect(
      CompletionPolicy::SchoolProgramPolicy
    ).to receive(:before_save).with(school_program)

    school_program.run_callbacks(:save){ false } #onlt run before callbacls
  end

  it "#completion_policy returns an instance of the proper completion_policy" do
    expect(school_program.completion_policy)
      .to be_an_instance_of CompletionPolicy::SchoolProgramPolicy
  end
end
