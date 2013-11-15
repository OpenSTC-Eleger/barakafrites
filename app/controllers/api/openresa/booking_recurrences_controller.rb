class Api::Openresa::BookingRecurrencesController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openresa::BookingRecurrence)

end

