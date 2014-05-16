##
#
# Barakafrites helps openerp 6 to speak REST
#
#    Copyright (C) 2013  Siclic
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##


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
