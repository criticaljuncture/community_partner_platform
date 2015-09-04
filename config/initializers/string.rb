class String
  def domify
    self.downcase.gsub(/_|\s/, '-')
  end
end
