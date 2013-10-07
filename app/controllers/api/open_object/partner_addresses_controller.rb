class Api::OpenObject::PartnerAddressesController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::PartnerAddress )

end