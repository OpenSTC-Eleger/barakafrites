class Openstc::InterventionCategory
  include OpenObjectModel
  set_open_object_model 'openstc.intervention.assignement'

  @@available_fields = %w(code id name)

  attr_accessor *@@available_fields

end