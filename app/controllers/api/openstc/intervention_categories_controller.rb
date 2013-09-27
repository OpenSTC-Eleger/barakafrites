class Api::Openstc::InterventionCategoriesController < Api::ResourceController
  resource_description do
    resource_id 'intervention_categories'
    formats ['json']
    short 'Deals with Intervention categories'
  end

  include Api::ApiControllerModule
  self.resource_model = ::Openstc::InterventionCategory

end