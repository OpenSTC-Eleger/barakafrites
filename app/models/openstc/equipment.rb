class Openstc::Equipment
  include OpenObjectModel

  set_open_object_model  'openstc.equipment'
  @@available_fields = %w( id name href maintenance_service_ids internal_use)
  attr_accessor *@@available_fields

end