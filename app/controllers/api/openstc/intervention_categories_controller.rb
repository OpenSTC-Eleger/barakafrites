class Api::Openstc::InterventionCategoriesController < Api::ResourceController
  include OpenObjectModel

  self.resource_model = ::Openstc::InterventionCategory

end