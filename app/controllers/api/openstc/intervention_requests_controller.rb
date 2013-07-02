class Api::Openstc::InterventionRequestsController < ApplicationController

  before_filter :check_authenticated?


  def index
    @filters = params[:filters] || []
    @fields = params[:fields] || []
    @intervention_requests = InterventionRequest.find_all(user_context,format_filters(@filters),@fields)
    backend_response_to_json @intervention_requests
  end

  def show
    @intervention_request = InterventionRequest.find_one(user_context, params[:id])
    backend_response_to_json @intervention_request
  end

  def update
    @update = InterventionRequest.write(user_context, [params[:id]],params[:intervention_request])
    backend_response_to_json @update
  end

  ##
  # TODO : Refactor to avoid code duplication
  #
  def create
    @create=  InterventionRequest.create_and_return(user_context, params[:intervention_request])
    backend_response_to_json @create
  end

end
