class SchoolQualityIndicatorSubAreasController < ApplicationController
  def index
    @school_quality_indicator_sub_areas = SchoolQualityIndicatorSubArea.all.order(:name)
  end

  def show
    @school_quality_indicator_sub_area = SchoolQualityIndicatorSubArea.find(params[:id])
    @top_5 = Organization.top_5_for_indicator(@school_quality_indicator_sub_area.id)
  end

  def new
    @school_quality_indicator_sub_area = SchoolQualityIndicatorSubArea.new
  end

  def create
    @school_quality_indicator_sub_area = SchoolQualityIndicatorSubArea.new(school_quality_indicator_sub_area_params)
    @school_quality_indicator_sub_area.save

    redirect_to school_quality_indicator_sub_area_path(@school_quality_indicator_sub_area)
  end

  def edit
    @school_quality_indicator_sub_area = SchoolQualityIndicatorSubArea.find(params[:id])
  end

  def update
    @school_quality_indicator_sub_area = SchoolQualityIndicatorSubArea.find(params[:id])
    @school_quality_indicator_sub_area.update_attributes(school_quality_indicator_sub_area_params)

    redirect_to school_quality_indicator_sub_area_path(@school_quality_indicator_sub_area)
  end

  private
  
  def school_quality_indicator_sub_area_params
    params.require(:school_quality_indicator_sub_area).permit(:name)
  end
end
