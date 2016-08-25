require 'spec_helper'

describe "CompletionRateCalculator" do

  describe "#completion_rate" do

    it "calculates rates correctly with a single rate" do
      organization = double
      organization.stub(:name).and_return("Test Org")
      organization.stub(:location)

      calculator = CompletionRateCalculator.new(
        organization,
        [
          [1.0, [:name, :location]],
        ]
      )

      expect(calculator.completion_rate).to eq(50.0)
    end

    it "calculates multiple rates correctly when two rates are the same" do
      organization = double
      organization.stub(:name).and_return("Test Org")
      organization.stub(:city).and_return([])
      organization.stub(:location)
      organization.stub(:address)

      calculator = CompletionRateCalculator.new(
        organization,
        [
          [0.5, [:name, :location]],
          [0.5, [:city, :address]],
        ]
      )

      expect(calculator.completion_rate).to eq(25.0)
    end

    it "calculates the same rate for community programs and school programs for when shared attributes are populated (apart from #school_programs and #community_program, respectively)." do
      community_program = double
      community_program_attributes = CommunityProgram::COMPLETION_WEIGHTS.map{|x| x[1]}.flatten
      community_program_attributes.each{|x| community_program.stub(x)}
      community_program.stub(:name).and_return("Community Program")
      community_program.stub(:student_population).and_return([1])
      community_program.stub(:school_programs).and_return([1])

      community_program_completion_rate = CompletionRateCalculator.new(
        community_program,
        CommunityProgram::COMPLETION_WEIGHTS
      ).completion_rate

      school_program = double
      school_program_attributes = SchoolProgram::COMPLETION_WEIGHTS.map{|x| x[1]}.flatten
      school_program_attributes.each{|x| school_program.stub(x) }
      school_program.stub(:name).and_return("School Program")
      school_program.stub(:student_population).and_return([1])
      school_program.stub(:community_program).and_return([1])

      school_program_completion_rate = CompletionRateCalculator.new(
        school_program,
        SchoolProgram::COMPLETION_WEIGHTS
      ).completion_rate

      expect(community_program_completion_rate).to eq(school_program_completion_rate)
    end

  end
end
