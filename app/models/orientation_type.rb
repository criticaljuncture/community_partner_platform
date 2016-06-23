class OrientationType < ActiveHash::Base
  include I18nAccessor

  i18n_accessor :name

  self.data = [
    {id: 1, identifier: :completed_orientation_agreement},
  ]

end
