class Openstc::EquipmentCategories
  include OpenObjectModel

  set_open_object_model  'product.category'
  @@available_fields = %w( id name href parent_id is_vehicle is_equipment)
  attr_accessor *@@available_fields

end