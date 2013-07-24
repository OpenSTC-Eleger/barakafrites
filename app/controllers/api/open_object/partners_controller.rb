class Api::OpenObject::PartnersController < Api::ResourceController
  include ApiController

  self.resource_model = (::OpenObject::Partner )

end