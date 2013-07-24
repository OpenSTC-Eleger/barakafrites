class OpenObject::User
  include OpenObjectModel
  set_open_object_model 'res.users'

  @@available_fields = %w(complete_name contact_id context_lang context_tz date firstname groups_id id isDST isManager lastname login name phone service_id service_ids tasks team_ids user_email)

  @@available_fields.each do |field|
    attr_accessor field
  end

  def self.authenticate(dbname, login, password)
    OpenObject.login(dbname, login, password).content
  end


  def manageable_officers(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = OpenObject::User.connection(user_context).execute(OpenObject::User.open_object_model, 'get_manageable_officers', self.id.to_i)
      OpenObject::BackendResponse.new(success: true, content: response)
    end


  end

  def manageable_teams(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = OpenObject::User.connection(user_context).execute(OpenObject::User.open_object_model, 'get_manageable_teams', self.id.to_i)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

end