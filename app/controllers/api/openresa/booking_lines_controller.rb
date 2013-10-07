class Api::Openresa::BookingLinesController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openresa::BookingLine)

end