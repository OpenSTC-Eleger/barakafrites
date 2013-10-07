class Api::Openstc::InterventionsController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = ::Openstc::Intervention

end