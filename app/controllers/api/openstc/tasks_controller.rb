class Api::Openstc::TasksController < Api::ResourceController
  include ApiController
  self.resource_model=(::Openstc::Task)


  def available_vehicles
    @task_id = params[:id]
    backend_response_to_json Openstc::Task.new(:id => @task_id).available_vehicles(user_context)
  end


  def available_equipments
    @task_id = params[:id]
    backend_response_to_json Openstc::Task.new(:id => @task_id).available_equipments(user_context)
  end

end