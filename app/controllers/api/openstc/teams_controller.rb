class Api::Openstc::TeamsController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openstc::Team)


end