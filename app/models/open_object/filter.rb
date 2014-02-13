class OpenObject::Filter
  include OpenObjectModel

  set_open_object_model 'ir.filters'


  @@available_fields = %w( id name href user_id domain context model_id description pre_recorded)
  attr_accessor *@@available_fields


end

