class Openstc::Site
  include OpenObjectModel
  set_open_object_model 'openstc.site'

  @@available_fields = %w(complete_name id href length name service_names service_ids site_parent_id surface type width actions internal_booking external_booking service_bookable_ids service_bookable_names partner_type_bookable_ids partner_type_bookable_names color product_id block_booking)

  @@available_fields.each do |field|
    attr_accessor field
  end

  @@related_fields = {"service_ids" => "Openstc::Department", "site_parent_id" => "Openstc::Site" }

end
