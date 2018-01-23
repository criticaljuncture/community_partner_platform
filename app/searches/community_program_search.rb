class CommunityProgramSearch < ApplicationSearch
  attr_reader :search_params, :query

  def initialize(params)
    @search_params = params
    @query = CommunityProgram.ransack(search_params)
  end

  def result
    query.result.includes(:organization)
  end

  def valid_search_params
    #params.whitelist
  end

  def csv
    # csv_array = []
    # result.each do |result|
      # csv_array << [result.id, result.name, 'etc', 'etc']
    # end

    # csv_array
  end
end


#new takes a set of parameters and creates an internal ransack search @query for them
 #results calls query.results and adds any needed includes, etc (eager loading)
 #csv calls #results.each and returns a CSV
