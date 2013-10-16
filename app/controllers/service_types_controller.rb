class ServiceTypesController < ApplicationController
  authorize_resource

  def index
    @quality_elements = QualityElement.accessible_by(current_ability).includes(:service_types).order("service_types.name")
  end

  def show
    @service_type = ServiceType.accessible_by(current_ability).find(params[:id])
  end

  def new
    @service_type = ServiceType.new
  end

  def create
    @service_type = ServiceType.new(service_type_params)
    @service_type.save

    redirect_to service_type_path(@service_type)
  end

  def edit
    @service_type = ServiceType.find(params[:id])
  end

  def update
    @service_type = ServiceType.find(params[:id])
    @service_type.update_attributes(service_type_params)

    redirect_to service_type_path(@service_type)
  end

  private
  
  def service_type_params
    params.
      require(:service_type).
      permit(:name, 
             quality_element_ids: [])
  end
  
end
