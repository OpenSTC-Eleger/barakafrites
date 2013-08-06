class Api::Openstc::SitesController < Api::ResourceController
    include ApiController

    self.resource_model = (::Openstc::Site)

  end