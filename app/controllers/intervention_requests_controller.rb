class InterventionRequestsController < ApplicationController
  before_filter :check_authenticated?


  def index
    @intervention_requests = InterventionRequest.where(user_context)
    respond_to do |format|
      format.json {render :json => @intervention_requests}
    end
  end

end
