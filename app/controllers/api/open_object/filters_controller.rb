class Api::OpenObject::FiltersController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::Filter )

end

