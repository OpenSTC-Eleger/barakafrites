class Api::OpenObject::FiltersController < Api::ResourceController
  include ApiController
  self.maping_model=(::OpenObject::Filter)

end

