class Openstc::AbsenceCategory
  include OpenObjectModel
  set_open_object_model 'openstc.absent.type'

  @@available_fields = %w( id name href code description actions)
  attr_accessor *@@available_fields

end