class OpenObject::User
  include OpenObjectModel
  set_open_object_model 'res.user'

  @@available_fields = %w(id name href)

  @@available_fields.each do |field|
    attr_accessor field
  end

end