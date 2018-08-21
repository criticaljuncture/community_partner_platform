require 'rails_helper'

RSpec.describe "CommunityProgramAuthorizationService" do
  context "#initialize" do
    it "supports passing an id" do
      program = FactoryBot.create(:community_program, :private)
      service = CommunityProgramAuthorizationService.new(program.id)

      expect(service.community_program).to eq(program)
    end

    it "supports passing an instance of CommunityProgram" do
      program = FactoryBot.create(:community_program, :private)
      service = CommunityProgramAuthorizationService.new(program)

      expect(service.community_program).to eq(program)
    end
  end

  it "#make_public! sets the proper attributes to make a community program public" do
    program = FactoryBot.create(:community_program, :private)

    current_user = create(:user)
    allow(User).to receive(:current).and_return(current_user)
    current_date_time = DateTime.parse("2018-01-01 12:00:00")
    allow(DateTime).to receive(:current).and_return(current_date_time)

    CommunityProgramAuthorizationService.new(program.id).make_public!
    program.reload

    expect(program.approved_for_public).to be_truthy
    expect(program.approved_for_public_on).to eq(current_date_time)
    expect(program.approved_for_public_by).to eq(current_user.id)
  end

  it "#make_private! sets the proper attributes to make a community program private" do
    program = FactoryBot.create(:community_program, :public)

    CommunityProgramAuthorizationService.new(program.id).make_private!
    program.reload

    expect(program.approved_for_public).to be_falsey
    expect(program.approved_for_public_on).to eq(nil)
    expect(program.approved_for_public_by).to eq(nil)
  end
end
