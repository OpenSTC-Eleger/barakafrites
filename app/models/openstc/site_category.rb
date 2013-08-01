class Openstc::SiteCategory
  include OpenObjectModel
  set_open_object_model 'openstc.site.type'

  @@available_fields = %w( id name href )
  attr_accessor *@@available_fields

end