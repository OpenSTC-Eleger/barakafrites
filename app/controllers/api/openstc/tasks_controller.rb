class Api::Openstc::TasksController < Api::ResourceController
  include ApiController
  self.resource_model=(::Openstc::Task)


end