class EventsController < ApplicationController
  def index
    @events = Event.active.accessible_by(current_ability).decorate
    authorize! :index, Event
  end

  def show
    @event = Event.
      includes(:locations, :organizations).
      find(params[:id]).
      decorate

    authorize! :show, @event
  end

  def new
    @event = Event.new
    authorize! :new, @event
  end

  def create
    event = Event.new(event_params)
    authorize! :create, event

    EventService.new(event, event_params).save!

    flash.notice = t('events.flash_messages.create.success',
      name: event.name)
    redirect_to event_path(event)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('errors.form_error', count: event.errors.count)
    render :new
  end

  def edit
    @event = Event.
      includes(:locations, :organizations).
      find(params[:id]).
      decorate

    authorize! :edit, @event
  end

  def update
    event = Event.find(params[:id])
    authorize! :update, event

    EventService.new(event, event_params).update!

    flash.notice = t('events.flash_messages.save.success',
      name: event.name)
    redirect_to event_path(event)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('errors.form_error', count: event.errors.count)
    render :edit
  end

  def table
    @events = Event.
      includes(:locations, :organizations).
      accessible_by(current_ability).
      order(:name).
      decorate

    authorize! :index, Event

    render layout: false
  end

  private

  def event_params
    params.require(:event).permit(
      :description,
      :end_date,
      :end_time,
      :name,
      :notes,
      :start_date,
      :start_time,
      location_ids: [],
      organization_ids: []
    )
  end
end
