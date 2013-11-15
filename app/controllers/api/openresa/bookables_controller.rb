class Api::Openresa::BookablesController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openresa::Bookable)

  api :GET, '/openresa/bookables/:id/available_quantity', 'Fetch quantity of bookable available (need checkin and checkout parameters)'
  def available_quantity
    @bookable = Openresa::Bookable.new(id: params[:id])
    backend_response_to_json  @bookable.available_quantity(user_context, params[:checkin], params[:checkout])
  end

end