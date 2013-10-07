class Api::Openstc::DepartmentsController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openstc::Department)

end