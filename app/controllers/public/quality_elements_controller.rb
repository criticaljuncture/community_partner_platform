class Public::QualityElementsController < Public::ApplicationController
  def show
    @quality_element = QualityElement.publicly_accessible.
      includes(
        :service_types,
        :community_programs
      ).
      find(params[:id])
  end
end
