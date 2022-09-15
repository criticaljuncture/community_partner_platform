class CommunityProgramAuthorizationService
  attr_reader :community_program

  def initialize(program_or_id)
    @community_program = program_or_id.is_a?(CommunityProgram) ? program_or_id : CommunityProgram.find(program_or_id)
  end

  def make_public!
    community_program.update!(
      approved_for_public: true,
      approved_for_public_on: DateTime.current,
      approved_for_public_by: User.current.id
    )
  end

  def make_private!
    community_program.update!(
      approved_for_public: false,
      approved_for_public_on: nil,
      approved_for_public_by: nil
    )
  end
end
