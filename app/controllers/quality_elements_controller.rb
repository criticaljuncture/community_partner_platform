class QualityElementsController < ApplicationController
  load_and_authorize_resource

  def index
    @quality_elements = QualityElement.accessible_by(current_ability).order(:name)
  end

  def show
    @quality_element = QualityElement.accessible_by(current_ability).find(params[:id])
  end

  def new
    @quality_element = QualityElement.new
  end

  def create
    @quality_element = QualityElement.new(quality_element_params)
    @quality_element.save

    redirect_to quality_element_path(@quality_element)
  end

  def edit
    @quality_element = QualityElement.find(params[:id])
  end

  def update
    @quality_element = QualityElement.find(params[:id])
    @quality_element.update_attributes(quality_element_params)

    redirect_to quality_element_path(@quality_element)
  end

  def service_type_inputs
    @quality_element = QualityElement.accessible_by(current_ability).includes(:service_types).find(params[:id])

    render "/community_partners/service_type_inputs", locals: {element_type: params[:type]}, layout: false
  end

  private
  
  def quality_element_params
    params.require(:quality_element).permit(:name, :element_type)
  end
end
