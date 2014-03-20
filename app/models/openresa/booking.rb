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


class Openresa::Booking
  include OpenObjectModel
  set_open_object_model 'hotel.reservation'


  @@available_fields = %w( id name href prod_id checkin checkout partner_id partner_order_id partner_type contact_phone partner_mail people_name people_email people_phone is_citizen create_date write_date deleted_at confirm_at done_at cancel_at state state_num actions reservation_line create_uid write_uid all_dispo recurrence_id is_template partner_invoice_id note confirm_note cancel_note done_note pricelist_id state_event resource_ids resources people_street people_city people_zip whole_day invoice_attachment_id amount_total)

  attr_accessor *@@available_fields

  def self.printable_planning_for(user_context, ids, start_date, end_date)
    OpenObject.rescue_xmlrpc_fault do
      response = self.connection(user_context).execute(self.open_object_model, 'generate_html_plannings_for', ids, start_date, end_date)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

end
