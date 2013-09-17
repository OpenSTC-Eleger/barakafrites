class Openstc::Task
  include OpenObjectModel

  set_open_object_model 'project.task'

  @@available_fields = %w(href site1 actions absent_type_id category_id date_end date_start effective_hours equipment_ids id km name oil_price oil_qtity planned_hours project_id remaining_hours state team_id total_hours user_id equipment_names)
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

