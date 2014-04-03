require 'spec_helper'

describe "User" do
  describe "organization member abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user) { build :organization_member }

    let(:school) { build :school }
    let(:community_program) { build :community_program }
    let(:organization) { build :organization }
    let(:quality_element) { build :quality_element }
    let(:service_time) { build :service_time }
    let(:service_type) { build :service_type }
    let(:student_population) { build :student_population }
    let(:day) { build :day }
    let(:grade_level) { build :grade_level }
    let(:demographic_group) { build :demographic_group }
    let(:ethnicity_culture_group) { build :ethnicity_culture_group }

    it "can"
      #expect(ability).to be_able_to(:index, School)
      #expect(ability).to be_able_to(:show, school)
    #end
  end
end
