class Openresa::BookingLine
  include OpenObjectModel
  set_open_object_model 'hotel_reservation.line'

  @@available_fields = %w( id name href )
  attr_accessor *@@available_fields

end