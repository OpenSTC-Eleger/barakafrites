class Api::Openstc::TeamsController < Api::ResourceController
  include ApiController
  self.maping_model=(::Openstc::Team)


end