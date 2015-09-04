Date::DATE_FORMATS[:default] = "%m/%d/%Y"
# "Friday, April 22nd, 2011"
Date::DATE_FORMATS[:formal] = lambda { |time| time.strftime("%A, %B #{time.day.ordinalize}, %Y") }

Time::DATE_FORMATS[:date] = "%m/%d/%Y"
Time::DATE_FORMATS[:default] = "%m/%d/%Y at %I:%M %p"
Time::DATE_FORMATS[:datetime_with_seconds] = "%m/%d/%Y at %I:%M:%S %p"
Time::DATE_FORMATS[:datetime_with_zone] = "%m/%d/%Y at %I:%M %p %Z"

Time::DATE_FORMATS[:date_at_time] = lambda { |time| time.strftime("%a, %b %e at %l:%M") + time.strftime("%p").downcase }
Time::DATE_FORMATS[:date_at_time_with_year] = lambda { |time| time.strftime("%a, %b %e, %Y at %l:%M") + time.strftime("%p").downcase }
# "Friday, April 22nd, 2011 at 1:30 PM"
Time::DATE_FORMATS[:formal_with_time] = lambda { |time| time.strftime("%A, %B #{time.day.ordinalize}, %Y at %I:%M %p") }
