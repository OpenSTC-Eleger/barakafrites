class Api::Openstc::TaskCategoriesController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = ::Openstc::TaskCategory

end