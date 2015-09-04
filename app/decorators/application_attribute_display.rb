class ApplicationAttributeDisplay
  attr_reader :d, :h

  delegate :h, :model, to: :@d
  delegate :capture, :concat, :content_tag, :t, to: :@h

  def initialize(decorator)
    @d = decorator
    @h = decorator.h
  end
end
