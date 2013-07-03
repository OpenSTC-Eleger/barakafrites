class Api::Openstc::EquipmentsController < Api::ResourceController
  include ApiController
  self.resource_model=(::Openstc::Equipment)

end