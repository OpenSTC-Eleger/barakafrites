class Openresa::Booking
  include OpenObjectModel
  set_open_object_model 'hotel.reservation'

  @@available_fields = %w( id name href prod_id checkin checkout partner_id partner_order_id partner_type partner_phone people_name people_email people_phone is_citizen create_date state state_num actions reservation_line create_uid resource_names resource_quantities all_dispo recurrence_id is_template )
  attr_accessor *@@available_fields

end
