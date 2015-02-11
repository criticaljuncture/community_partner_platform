class BasePresenter < SimpleDelegator
  attr_reader :model, :view

  def initialize(model, view)
    @model, @view = model, view
    super(@model)
  end

  def h
    view
  end
end
