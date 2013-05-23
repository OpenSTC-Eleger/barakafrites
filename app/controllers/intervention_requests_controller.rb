class InterventionRequestsController < ApplicationController
  before_filter :check_authenticated?


  def index
    @intervention_requests_ids = InterventionRequest.where(user_context)
    @intervention_requests = InterventionRequest.find(user_context,@intervention_requests_ids)
    respond_to do |format|
      format.json {render :json => @intervention_requests}
    end
  end

end
