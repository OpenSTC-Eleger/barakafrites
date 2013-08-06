class Openstc::Equipment
  include OpenObjectModel
  set_open_object_model = 'openstc.equipment'
  @@available_fields = %w( id name href )
  attr_accessor *@@available_fields

end