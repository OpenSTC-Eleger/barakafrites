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

end