class Openstc::TaskCategory
  include OpenObjectModel

  set_open_object_model 'openstc.task.category'

  @@available_fields = %w(code complete_name id name parent_id service_ids service_names actions)
  attr_accessor *@@available_fields

end