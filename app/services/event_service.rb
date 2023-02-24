class EventService
  attr_reader :event, :params

  def initialize(event, params)
    @event = event
    @params = params
  end

  def save!
    handle_dates
    event.save!
  end

  def update!
    event.update(params)
    handle_dates
    event.save!
  end

  private

  ################################################################
  # Supporting start and end times as virtual attributes
  # but storing a single DateTime in the database
  ################################################################
  def handle_dates
    if params[:start_date].present?
      event.start_date = combine_date_and_time(
        params[:start_date],
        params[:start_time]
      )
    end

    if params[:end_date].present?
      event.end_date = combine_date_and_time(
        params[:end_date],
        params[:end_time]
      )
    end
  end

  def combine_date_and_time(date, time)
    if date.present?
      time = "00:00" unless time.present?

      DateTime.parse(
        "#{date.to_date.to_s(:iso)} #{time} #{Time.current.formatted_offset}"
      )
    end
  end
end
