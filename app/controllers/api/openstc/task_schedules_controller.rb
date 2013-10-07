class Api::Openstc::TaskSchedulesController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::Openstc::TaskSchedule)

end