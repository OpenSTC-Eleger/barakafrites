class Api::Openstc::AbsenceCategoriesController <  Api::ResourceController
  include ApiController

  self.maping_model = (::Openstc::AbsenceCategory)

end