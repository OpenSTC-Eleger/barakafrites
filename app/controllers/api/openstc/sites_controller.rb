class Api::Openstc::SitesController < ApplicationController
    include ApiController

    self.resource_model = (::Openstc::Site)

  end