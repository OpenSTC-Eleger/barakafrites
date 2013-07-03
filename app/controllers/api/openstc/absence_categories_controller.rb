class Api::Openstc::AbsenceCategoriesController <  Api::ResourceController
  include ApiController

  self.resource_model = (::Openstc::AbsenceCategory)

end