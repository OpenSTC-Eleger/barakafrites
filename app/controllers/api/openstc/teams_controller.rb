class Api::Openstc::TeamsController < Api::ResourceController
  include ApiController
  self.resource_model=(::Openstc::Team)


end