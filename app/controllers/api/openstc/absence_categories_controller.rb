class Api::Openstc::AbsenceCategoriesController <  Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::Openstc::AbsenceCategory)

end