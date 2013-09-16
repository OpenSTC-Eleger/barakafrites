class Openstc::Equipment
  include OpenObjectModel

  set_open_object_model  'openstc.equipment'
  @@available_fields = %w( id name href maintenance_service_ids internal_use service_ids immat marque usage type cv year time km energy_type length_amort purchase_price default_code categ_id service_names maintenance_service_names)
  attr_accessor *@@available_fields

end