class Api::Openstc::EquipmentsController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openstc::Equipment)

end