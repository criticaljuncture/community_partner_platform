require 'spec_helper'

describe "User" do
  describe "public_abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user) { nil }

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

    it "can read Schools" do
      expect(ability).to be_able_to(:index, School)
      expect(ability).to be_able_to(:show, school)
    end

    it "can read Community Programs" do
      expect(ability).to be_able_to(:index, CommunityProgram)
      expect(ability).to be_able_to(:show, community_program)
    end

    it "can read Organizations" do
      expect(ability).to be_able_to(:index, Organization)
      expect(ability).to be_able_to(:show, organization)
    end

    it "can read Quality Elements" do
      expect(ability).to be_able_to(:index, QualityElement)
      expect(ability).to be_able_to(:show, quality_element)
    end

    it "can read Service Times" do
      expect(ability).to be_able_to(:index, ServiceTime)
      expect(ability).to be_able_to(:show, service_time)
    end

    it "can read Service Types" do
      expect(ability).to be_able_to(:index, ServiceType)
      expect(ability).to be_able_to(:show, service_type)
    end

    it "can read Student Populations" do
      expect(ability).to be_able_to(:index, StudentPopulation)
      expect(ability).to be_able_to(:show, student_population)
    end

    it "can read Days" do
      expect(ability).to be_able_to(:index, Day)
      expect(ability).to be_able_to(:show, day)
    end

    it "can read Grade Levels" do
      expect(ability).to be_able_to(:index, GradeLevel)
      expect(ability).to be_able_to(:show, grade_level)
    end

    it "can read Demographic Groups" do
      expect(ability).to be_able_to(:index, DemographicGroup)
      expect(ability).to be_able_to(:show, demographic_group)
    end

    it "can read Ethnicity Culture Groups" do
      expect(ability).to be_able_to(:index, EthnicityCultureGroup)
      expect(ability).to be_able_to(:show, ethnicity_culture_group)
    end
  end
end
