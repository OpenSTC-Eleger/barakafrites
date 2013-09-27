class Api::Openstc::SiteCategoriesController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openstc::SiteCategory)

end