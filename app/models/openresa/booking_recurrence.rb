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

