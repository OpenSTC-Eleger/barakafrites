class Api::OpenObject::UsersController < Api::ResourceController
  include ApiController

  self.resource_model = (::OpenObject::User )

  def manageable_officers
    @user = OpenObject::User.new(id: params[:id])
    backend_response_to_json  @user.manageable_officers(user_context)
  end

  def manageable_teams
    @user = OpenObject::User.new(id: params[:id])
    backend_response_to_json  @user.manageable_teams(user_context)
  end

  def scheduled_tasks
    @filters = format_filters(params[:filters])
    @user = OpenObject::User.new(id: params[:id])
    backend_response_to_json @user.scheduled_tasks(user_context, @filters )
  end

  def available_vehicles
    @user = OpenObject::User.new(:id => params[:id])
    backend_response_to_json @user.available_vehicles(user_context)
  end

  def available_equipments
    @user = OpenObject::User.new(:id => params[:id])
    backend_response_to_json @user.available_equipments(user_context)
  end

end