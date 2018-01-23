class Admin::SearchController < Admin::ApplicationController
  def index
    authorize! :view, :search

    @params = params[:q]

    if @params
      @query = CommunityProgramSearch.search(params[:q].permit!).query
      @results = @query.result.order(:name)
    else
      @results = []
    end
  end
end
