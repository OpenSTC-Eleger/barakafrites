class Api::Openstc::EquipmentCategoriesController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openstc::EquipmentCategories)

end