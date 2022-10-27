class ServiceTypesController < ApplicationController
  def index
    @quality_elements = QualityElement.accessible_by(current_ability).includes(:service_types).order("service_types.name")
    authorize! :index, QualityElement
  end

  def show
    @service_type = ServiceType.find(params[:id])
    authorize! :show, @service_type
  end

  def new
    @service_type = ServiceType.new
    authorize! :new, @service_type
  end

  def create
    @service_type = ServiceType.new(service_type_params)
    authorize! :create, @service_type

    @service_type.save

    redirect_to service_type_path(@service_type)
  end

  def edit
    @service_type = ServiceType.find(params[:id])
    authorize! :edit, @service_type
  end

  def update
    @service_type = ServiceType.find(params[:id])
    authorize! :update, @service_type

    @service_type.update(service_type_params)

    redirect_to service_type_path(@service_type)
  end

  private

  def service_type_params
    params.
      require(:service_type).
      permit(
        :name,
        quality_element_ids: []
      )
  end

end
