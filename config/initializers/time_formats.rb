Time::DATE_FORMATS[:date_at_time] = lambda { |time| time.strftime("%a, %b %e at %l:%M") + time.strftime("%p").downcase }
