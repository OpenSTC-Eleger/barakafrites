class Api::OpenObject::PartnerTypesController < Api::ResourceController
  include ApiController

  self.resource_model = (::OpenObject::PartnerType )

end