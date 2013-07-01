class Api::Openstc::SitesController < ApplicationController

  before_filter :check_authenticated?

  def index
    @fields = params[:fields] || []
    @filters = params[:filters] || []
    @sites = Openstc::Site.find_all(user_context, format_filters(@filters), @fields)
    backend_response_to_json @sites
  end

  def create
    @site = params[:site]
    @create = Openstc::Site.create(user_context, @site)
    backend_response_to_json @create
  end

  def show
    @site = Openstc::Site.find_one(user_context, params[:id], params[:fields])
    backend_response_to_json @site
  end

  def update
    @attributes = params[:site]
    @update = Openstc::Site.write_one(user_context, params[:id], @attributes)
    backend_response_to_json @update
  end

end