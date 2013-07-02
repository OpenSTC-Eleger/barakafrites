class Api::Openstc::DepartmentsController < Api::ResourceController
  include ApiController
  self.maping_model=(::Openstc::Department)

end