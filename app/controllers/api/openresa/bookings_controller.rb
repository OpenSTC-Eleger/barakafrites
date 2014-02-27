##
#
# Barakafrites helps openerp 6 to speak REST
#
#    Copyright (C) 2013  Siclic
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##


class Api::Openresa::BookingsController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openresa::Booking)

  def print_planning
    @html = Openresa::Booking.printable_planning_for(user_context, params[:ids], params[:start_date], params[:end_date]).content
    render inline: @html, content_type: 'text/html'
  end

end