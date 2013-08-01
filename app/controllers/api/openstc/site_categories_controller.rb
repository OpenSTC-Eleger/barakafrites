class Api::Openstc::SiteCategoriesController < Api::ResourceController
  include ApiController
  self.resource_model=(::Openstc::SiteCategory)

end