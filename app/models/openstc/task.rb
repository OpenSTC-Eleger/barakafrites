class Openstc::Task
  include OpenObjectModel

  set_open_object_model 'project.task'

  @@available_fields = %w(id href name)
  attr_accessor *@@available_fields


  def available_vehicles(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = self.class.connection(user_context).execute(self.class.open_object_model, 'get_vehicules_authorized', self.id)
      BackendResponse.new(success: true, content: response)
    end
  end

  def available_equipments(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = self.class.connection(user_context).execute(self.class.open_object_model, 'get_materials_authorized', self.id)
      BackendResponse.new(success: true, content: response)
    end
  end

end

