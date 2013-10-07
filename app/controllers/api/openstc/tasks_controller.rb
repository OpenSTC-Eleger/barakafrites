class Api::Openstc::TasksController < Api::ResourceController
  resource_description do
    short 'Specific URIs to interact with/from tasks'
  end
  include Api::ApiControllerModule
  self.resource_model=(::Openstc::Task)

  api :GET, '/openstc/tasks/:id/available_vehicles', 'Fetch available vehicles to complete this task '
  def available_vehicles
    @task_id = params[:id]
    backend_response_to_json Openstc::Task.new(:id => @task_id).available_vehicles(user_context)
  end


  api :GET, '/openstc/tasks/:id/available_equipments', 'Fetch available equipments to complete this task'
  def available_equipments
    @task_id = params[:id]
    backend_response_to_json Openstc::Task.new(:id => @task_id).available_equipments(user_context)
  end

end