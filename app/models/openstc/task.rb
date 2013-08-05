class Openstc::Task
  include OpenObjectModel

  set_open_object_model 'openstc.task'

  @@available_fields = %w(id href name)
  attr_accessor *@@available_fields

end

