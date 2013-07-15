class Openstc::Department
  include OpenObjectModel
  set_open_object_model 'openstc.service'

  @@available_fields = %w(id href name complete_name code)
  attr_accessor *@@available_fields

end