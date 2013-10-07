class Api::OpenObject::PartnerTypesController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::PartnerType )

end