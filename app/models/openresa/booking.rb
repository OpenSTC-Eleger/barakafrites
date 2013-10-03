class Openresa::Booking
  include OpenObjectModel
  set_open_object_model 'hotel.reservation'

  @@available_fields = %w( id name href )
  attr_accessor *@@available_fields

end