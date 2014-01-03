class Api::Openresa::BookingsController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openresa::Booking)

  def print_planning
    @html = Openresa::Booking.printable_planning_for(user_context, params[:ids], params[:start_date], params[:end_date]).content
    render inline: @html, content_type: 'text/html'
  end

end