class Openstc::Department
  include OpenObjectModel
  set_open_object_model 'openstc.services'

  @@available_fields = %w(id href name)
  attr_accessor *@@available_fields

end