class Openresa::Booking
  include OpenObjectModel
  set_open_object_model 'hotel.reservation'


  @@available_fields = %w( id name href prod_id checkin checkout partner_id partner_order_id partner_type contact_phone partner_mail people_name people_email people_phone is_citizen create_date write_date deleted_at confirm_at done_at cancel_at state state_num actions reservation_line create_uid write_uid all_dispo recurrence_id is_template partner_invoice_id note confirm_note cancel_note done_note pricelist_id state_event resource_ids resources people_street people_city people_zip whole_day invoice_attachment_id)

  attr_accessor *@@available_fields

  def self.printable_planning_for(user_context, ids, start_date, end_date)
    OpenObject.rescue_xmlrpc_fault do
      response = self.connection(user_context).execute(self.open_object_model, 'generate_html_plannings_for', ids, start_date, end_date)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

end
