class Api::Openstc::EquipmentCategoriesController < Api::ResourceController
  include ApiController
  self.resource_model=(::Openstc::EquipmentCategories)

end