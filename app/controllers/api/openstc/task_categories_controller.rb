class Api::Openstc::TaskCategoriesController < Api::ResourceController
  include ApiController

  self.maping_model = ::Openstc::TaskCategory

end