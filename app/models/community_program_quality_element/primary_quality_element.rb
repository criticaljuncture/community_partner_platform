class PrimaryQualityElement < CommunityProgramQualityElement
  delegate :programmatic?, :foundational?, to: :quality_element
end
