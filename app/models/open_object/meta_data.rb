class OpenObject::MetaData
  include OpenObjectModel

  set_open_object_model 'ir.model'


  @@available_fields = %w( id name href model info )
  attr_accessor *@@available_fields

  def filters(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = OpenObject::MetaData.connection(user_context).execute(OpenObject::MetaData.open_object_model, 'get_filters', self.id.to_i)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end


end

