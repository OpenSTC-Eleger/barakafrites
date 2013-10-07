class Api::Openstc::InterventionRequestsController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = ::Openstc::InterventionRequest

end
