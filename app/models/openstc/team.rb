class Openstc::Team
  include OpenObjectModel

  set_open_object_model 'openstc.team'

  @@available_fields = %w(id href name manager_id)
  attr_accessor *@@available_fields

end

