require 'rails_helper'

RSpec.describe "OrganizationAuthorizationService" do
  context "#initialize" do
    it "supports passing an id" do
      organization = FactoryBot.create(:organization, :private)
      service = OrganizationAuthorizationService.new(organization.id)

      expect(service.organization).to eq(organization)
    end

    it "supports passing an instance of Organization" do
      organization = FactoryBot.create(:organization, :private)
      service = OrganizationAuthorizationService.new(organization)

      expect(service.organization).to eq(organization)
    end
  end

  describe "#make_public!" do
    let(:organization) { FactoryBot.create(:organization, :private) }
    let(:current_user) { create(:user) }
    let(:current_date_time) { DateTime.parse("2018-01-01 12:00:00") }

    before(:each) do
      allow(User).to receive(:current).and_return(current_user)
      allow(DateTime).to receive(:current).and_return(current_date_time)
    end

    it "sets the proper attributes to make a community program public" do
      OrganizationAuthorizationService.new(organization.id).make_public!
      organization.reload

      expect(organization.approved_for_public).to be_truthy
      expect(organization.approved_for_public_on).to eq(current_date_time)
      expect(organization.approved_for_public_by).to eq(current_user.id)
    end

    it "makes eligible community programs public if passed the proper options" do
      allow_any_instance_of(CommunityProgram).to receive(
        :eligible_to_be_made_public?
      ).and_return(true)

      community_programs = create_list(:community_program, 2, :private)
      organization.community_programs = community_programs

      expect(community_programs.all?{|cp| cp.approved_for_public?}).to be_falsey

      OrganizationAuthorizationService.new(organization.id)
        .make_public!(include_eligible_programs: "1")
      organization.reload
      community_programs.each(&:reload)

      expect(organization.approved_for_public).to be_truthy
      expect(community_programs.all?{|cp| cp.approved_for_public?}).to be_truthy
    end
  end

  describe "#make_private!" do
    let(:organization) { FactoryBot.create(:organization, :public) }
    
    it "sets the proper attributes to make a community program private" do
      OrganizationAuthorizationService.new(organization.id).make_private!
      organization.reload

      expect(organization.approved_for_public).to be_falsey
      expect(organization.approved_for_public_on).to eq(nil)
      expect(organization.approved_for_public_by).to eq(nil)
    end

    it "makes all associated community programs private" do
      allow_any_instance_of(CommunityProgram).to receive(
        :eligible_to_be_made_public?
      ).and_return(true)

      community_programs = create_list(:community_program, 2, :public)
      organization.community_programs = community_programs

      expect(community_programs.all?{|cp| cp.approved_for_public?}).to be_truthy

      OrganizationAuthorizationService.new(organization.id)
        .make_private!
      organization.reload
      community_programs.each(&:reload)

      expect(organization.approved_for_public).to be_falsey
      expect(community_programs.all?{|cp| cp.approved_for_public?}).to be_falsey
    end
  end
end
