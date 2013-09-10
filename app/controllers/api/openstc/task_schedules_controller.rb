class Api::Openstc::TaskSchedulesController < Api::ResourceController
  include ApiController

  self.resource_model = (::Openstc::TaskSchedule)

end