class Api::OpenObject::PartnersController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::Partner )

end