class Api::Openresa::BookingRecurrencesController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openresa::BookingRecurrence)

  api :GET, '/openresa/recurrence_dates', 'Compute and returns dates according to recurrence setting, mandatory: type (daily, weekly, daymonthly, weekdaymonthly)'
  def get_dates
    type = params[:type]

    case type
    when 'daily'
      backend_response_to_json  Openresa::BookingRecurrence.get_dates_from_daily_setting(user_context, params[:date_start], params[:weight].to_i, params[:date_end], params[:count].to_i)
    when 'weekly'
      backend_response_to_json  Openresa::BookingRecurrence.get_dates_from_weekly_setting(user_context, params[:date_start], params[:weight].to_i, params[:weekdays], params[:date_end], params[:count].to_i)
    when 'daymonthly'
      backend_response_to_json  Openresa::BookingRecurrence.get_dates_from_daymonthly_setting(user_context, params[:date_start], params[:weight].to_i, params[:monthday].to_i, params[:date_end], params[:count].to_i)
    when 'weekdaymonthly'
      backend_response_to_json  Openresa::BookingRecurrence.get_dates_from_weekdaymonthly_setting(user_context, params[:date_start], params[:weight].to_i, params[:relative_position], params[:weekday], params[:date_end], params[:count].to_i)
    end
  end
end