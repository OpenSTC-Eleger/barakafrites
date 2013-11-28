class Openresa::BookingRecurrence
  include OpenObjectModel
  set_open_object_model 'openresa.reservation.recurrence'

  @@available_fields = %w( id name actions )
  attr_accessor *@@available_fields


end

