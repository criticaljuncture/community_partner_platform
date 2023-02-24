class EventDecorator < Draper::Decorator
  delegate_all

  def start_date
    # midnight events as just an event without a time associated
    if object.start_date.strftime("%H:%M") == "00:00"
      object.start_date.to_date
    else
      object.start_date
    end
  end

  def end_date
    # midnight events as just an event without a time associated
    if object.end_date.strftime("%H:%M") == "00:00"
      object.end_date.to_date
    else
      object.end_date
    end
  end
end
