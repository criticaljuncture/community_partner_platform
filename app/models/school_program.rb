class SchoolProgram < ActiveRecord::Base
  include CommunityProgramAttributeRelationships
  belongs_to :community_program

  belongs_to :school_user,
    class_name: User,
    foreign_key: :school_user_id

    validates :school_id,
      presence: {
        message: "must choose a school"
      }
end
