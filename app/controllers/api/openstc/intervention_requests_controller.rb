class Api::Openstc::InterventionRequestsController < Api::ResourceController
  include ApiController

  self.resource_model = ::Openstc::InterventionRequest

end
