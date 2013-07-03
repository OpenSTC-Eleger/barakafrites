class Api::Openstc::EquipmentsController < Api::ResourceController
  include ApiController
  self.maping_model=(::Openstc::Equipment)

end