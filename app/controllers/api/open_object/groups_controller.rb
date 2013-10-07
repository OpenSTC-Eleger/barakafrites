class Api::OpenObject::GroupsController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::Group )

end