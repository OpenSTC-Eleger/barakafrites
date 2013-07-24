class Openstc::Department
  include OpenObjectModel
  set_open_object_model 'openstc.service'

  @@available_fields = %w(category_ids code id manager_id name service_id technical user_ids)
  attr_accessor *@@available_fields

end