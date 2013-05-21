class InterventionRequestsController < ApplicationController

  def index
    @intervention_requests = InterventionRequest.where(user_context,params[:filters])
    respond_to :format do |format|
      format.json render :json => @intervention_requests
    end
  end

end
