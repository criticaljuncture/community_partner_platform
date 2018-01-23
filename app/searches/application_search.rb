class ApplicationSearch
  class NoMatchingSearch < StandardError; end

  def self.search(params)
    new(params)
  end
end
