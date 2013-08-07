class Openstc::Site
  include OpenObjectModel
  set_open_object_model 'openstc.site'

  @@available_fields = %w(complete_name id length name service_names service_ids site_parent_id surface type width href actions)

  @@available_fields.each do |field|
    attr_accessor field
  end

end