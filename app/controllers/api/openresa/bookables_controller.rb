class Api::Openresa::BookablesController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openresa::Bookable)

end