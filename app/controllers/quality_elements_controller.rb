class QualityElementsController < ApplicationController

  def index
    @quality_elements = QualityElement.accessible_by(current_ability).order(:name)
    authorize! :read, QualityElement
  end

  def show
    @quality_element = QualityElement.accessible_by(current_ability).find(params[:id])
    authorize! :read, @quality_element
  end

  def new
    @quality_element = QualityElement.new
    authorize! :create, @quality_element
  end

  def create
    @quality_element = QualityElement.new(quality_element_params)
    authorize! :create, @quality_element

    @quality_element.save

    redirect_to quality_element_path(@quality_element)
  end

  def edit
    @quality_element = QualityElement.find(params[:id])
    authorize! :edit, @quality_element
  end

  def update
    @quality_element = QualityElement.find(params[:id])
    authorize! :edit, @quality_element

    @quality_element.update(quality_element_params)

    redirect_to quality_element_path(@quality_element)
  end

  def service_type_inputs
    @quality_element = QualityElement.accessible_by(current_ability).
      includes(:service_types).find(params[:id])
    authorize! :read, @quality_element

    render "/community_programs/service_type_inputs", locals: {
      element_type: params[:type]
    }, layout: false
  end

  private

  def quality_element_params
    params.require(:quality_element).permit(:name, :element_type)
  end
end
