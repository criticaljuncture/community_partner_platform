class OrientationType < ActiveHash::Base
  include I18nAccessor

  i18n_accessor :name

  self.data = [
    {id: 1, identifier: :sample_orientation_type_1},
    {id: 2, identifier: :sample_orientation_type_2},
  ]

end
