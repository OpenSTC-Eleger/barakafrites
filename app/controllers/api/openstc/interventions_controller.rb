class Api::Openstc::InterventionsController < Api::ResourceController
  include ApiController

  self.resource_model = ::Openstc::Intervention

end