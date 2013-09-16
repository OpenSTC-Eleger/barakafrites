class Api::OpenObject::GroupsController < Api::ResourceController
  include ApiController

  self.resource_model = (::OpenObject::Group )

end