class Api::OpenObject::UsersController < Api::ResourceController
  resource_description do
    short 'Interact with/from users'
    formats ['json']
  end
  apipie_concern_subst({:controller_path => '/bar', :resource_id => 'foo'})

  include Api::ApiControllerModule
  self.resource_model = (::OpenObject::User )




  api :GET, "/open_object/users/:id/manageable_officers"
  def manageable_officers
    @user = OpenObject::User.new(id: params[:id])
    backend_response_to_json  @user.manageable_officers(user_context)
  end

  api :GET, "/open_object/users/:id/manageable_teams"
  def manageable_teams
    @user = OpenObject::User.new(id: params[:id])
    backend_response_to_json  @user.manageable_teams(user_context)
  end

  api :GET, "/open_object/users/:id/scheduled_tasks"
  def scheduled_tasks
    @filters = format_filters(params[:filters])
    @user = OpenObject::User.new(id: params[:id])
    backend_response_to_json @user.scheduled_tasks(user_context, @filters )
  end

  api :GET, "/open_object/users/:id/available_vehicles"
  def available_vehicles
    @user = OpenObject::User.new(:id => params[:id])
    backend_response_to_json @user.available_vehicles(user_context)
  end

  api :GET, "/open_object/users/:id/available_equipments"
  def available_equipments
    @user = OpenObject::User.new(:id => params[:id])
    backend_response_to_json @user.available_equipments(user_context)
  end

end