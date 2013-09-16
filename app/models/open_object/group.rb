class OpenObject::Group
  include OpenObjectModel

  set_open_object_model 'res.groups'

  @@available_fields = %w( name )
  attr_accessor *@@available_fields

end