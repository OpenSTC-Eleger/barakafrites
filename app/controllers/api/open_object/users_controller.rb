class Api::OpenObject::UsersController < Api::ResourceController
  include ApiController

  self.resource_model = (::OpenObject::User )

end