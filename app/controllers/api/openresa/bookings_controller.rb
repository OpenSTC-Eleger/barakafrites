class Api::Openresa::BookingsController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openresa::Booking)

end