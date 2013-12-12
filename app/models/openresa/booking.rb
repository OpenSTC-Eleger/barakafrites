class Openresa::Booking
  include OpenObjectModel
  set_open_object_model 'hotel.reservation'

  @@available_fields = %w( id name href prod_id checkin checkout partner_id partner_order_id partner_type contact_phone partner_mail people_name people_email people_phone is_citizen create_date write_date state state_num actions reservation_line create_uid write_uid resource_names resource_quantities all_dispo recurrence_id is_template partner_invoice_id note confirm_note cancel_note done_note pricelist_id state_event resource_ids resource_types resources)
  attr_accessor *@@available_fields

end
