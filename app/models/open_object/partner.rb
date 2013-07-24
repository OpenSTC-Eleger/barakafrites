class OpenObject::Partner
  include OpenObjectModel

  set_open_object_model 'res.partner'

  @@available_fields = %w(address category_id contract_ids id email name phone service_id task_ids technical_service_id technical_site_id title type_id user_id)
  attr_accessor *@@available_fields

end