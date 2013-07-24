class Api::OpenObject::PartnerAddressesController < Api::ResourceController
  include ApiController

  self.resource_model = (::OpenObject::PartnerAddress )

end