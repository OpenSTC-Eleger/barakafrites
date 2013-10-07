class Api::Openstc::SitesController < Api::ResourceController
    include Api::ApiControllerModule

    self.resource_model = (::Openstc::Site)

  end