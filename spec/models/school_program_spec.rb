require 'spec_helper'

describe SchoolProgram do
  # Moved from completion rate calculator spec as it relates to school
  # programs and inheritance rather than the calculator.
  # Needs some love to make delegation work in the spec.

  # context "for community programs and school programs (inherited attributes)" do
  #   let(:community_program) { double }
  #   let(:school_program) { double }
  #
  #   before(:each) do
  #     community_program_attributes = CommunityProgram::COMPLETION_WEIGHTS.map{|x| x[1]}.flatten
  #     community_program_attributes.each{|x| community_program.stub(x)}
  #
  #     school_program_attributes = SchoolProgram::COMPLETION_WEIGHTS.map{|x| x[1]}.flatten
  #     school_program_attributes.each{|x| school_program.stub(x)}
  #   end
  #
  #   it "calculates the same rate when shared attributes aren't changed" do
  #     community_program.stub(:name).and_return("Community Program")
  #     community_program.stub(:student_population).and_return([1])
  #     community_program.stub(:school_programs).and_return([1])
  #
  #     community_program_completion_rate = CompletionRateCalculator.new(
  #       community_program,
  #       CommunityProgram::COMPLETION_WEIGHTS
  #     ).completion_rate
  #
  #
  #     school_program.stub(:name).and_return("School Program")
  #     school_program.stub(:community_program).and_return(community_program)
  #
  #     school_program_completion_rate = CompletionRateCalculator.new(
  #       school_program,
  #       SchoolProgram::COMPLETION_WEIGHTS
  #     ).completion_rate
  #
  #     expect(community_program_completion_rate).to eq(school_program_completion_rate)
  #   end
  # end
end
