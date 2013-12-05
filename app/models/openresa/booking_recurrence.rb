class Openresa::BookingRecurrence
  include OpenObjectModel
  set_open_object_model 'openresa.reservation.recurrence'

  @@available_fields = %w( id name actions href recur_periodicity recur_week_monday recur_week_tuesday recur_week_wednesday recur_week_thursday recur_week_friday recur_week_saturday recur_week_sunday recur_month_type recur_month_absolute recur_month_relative_weight recur_month_relative_day recur_type date_start recur_length_type date_end recur_occurrence_nb date_confirm recurrence_state actions state_event reservation_ids)  

  attr_accessor *@@available_fields

  def self.get_dates_from_daily_setting(user_context, date_start, weight, date_end, count)
    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::BookingRecurrence.connection(user_context).execute(Openresa::BookingRecurrence.open_object_model, 'get_dates_from_daily_setting', date_start, weight, date_end, count)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

  def self.get_dates_from_weekly_setting(user_context, date_start, weight, weekdays, date_end, count)
    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::BookingRecurrence.connection(user_context).execute(Openresa::BookingRecurrence.open_object_model, 'get_dates_from_weekly_setting', date_start, weight, weekdays, date_end, count)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

  def self.get_dates_from_daymonthly_setting(user_context, date_start, weight, day, date_end, count)
    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::BookingRecurrence.connection(user_context).execute(Openresa::BookingRecurrence.open_object_model, 'get_dates_from_daymonthly_setting', date_start, weight, day, date_end, count)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

  def self.get_dates_from_weekdaymonthly_setting(user_context, date_start, weight, relative_position, weekday, date_end, count)
    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::BookingRecurrence.connection(user_context).execute(Openresa::BookingRecurrence.open_object_model, 'get_dates_from_weekdaymonthly_setting', date_start, weight, relative_position, weekday, date_end, count)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

end

