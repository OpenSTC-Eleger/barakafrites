class Api::Openstc::DepartmentsController < Api::ResourceController
  include ApiController
  self.resource_model=(::Openstc::Department)

end