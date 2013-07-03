class Api::Openstc::TaskCategoriesController < Api::ResourceController
  include ApiController

  self.resource_model = ::Openstc::TaskCategory

end