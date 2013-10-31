class Openresa::Booking
  include OpenObjectModel
  set_open_object_model 'hotel.reservation'

  @@available_fields = %w( id name href prod_id checkin checkout partner_id create_date state actions reservation_line )
  attr_accessor *@@available_fields

end
