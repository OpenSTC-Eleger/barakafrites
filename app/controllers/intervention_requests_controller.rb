class InterventionRequestsController < ApplicationController
  before_filter :check_authenticated?


  def index
    @intervention_requests_ids = InterventionRequest.where(user_context)
    @intervention_requests = InterventionRequest.find(user_context,@intervention_requests_ids)
    respond_to do |format|
      format.json {render :json => @intervention_requests}
    end
  end

  def show
    @intervention_request = InterventionRequest.find(user_context, [params[:id]]).first
    respond_to do |format|
      format.json {render :json => @intervention_request}
    end
  end

  def update
    @update = InterventionRequest.write(user_context, [params[:id]],params[:intervention_request])
    if @update[:success]
      respond_to do |format|
        format.json {render :json => @update}
      end
    else
      respond_to do |format|
        format.json { render :json => @update, :status =>  400}
      end
    end
  end

end
