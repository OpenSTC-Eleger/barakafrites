class OpenObject::User
  include OpenObjectModel
  set_open_object_model 'res.users'

  @@available_fields = %w(id name href menu_id groups_id)

  @@available_fields.each do |field|
    attr_accessor field
  end

  def self.authenticate(dbname,login,password)
    OpenObject.login(dbname,login,password).content
  end

end