class Openstc::Equipment
  include OpenObjectModel

  set_open_object_model  'openstc.equipment'
  @@available_fields = %w( id name href maintenance_service_ids internal_use service_ids immat marque usage type cv time km energy_type length_amort purchase_price default_code categ_id service_names maintenance_service_names complete_name product_product_id warranty_date purchase_date hour_price built_date internal_booking external_booking service_bookable_ids service_bookable_names partner_type_bookable_ids partner_type_bookable_names qty_available color)
  attr_accessor *@@available_fields

end
