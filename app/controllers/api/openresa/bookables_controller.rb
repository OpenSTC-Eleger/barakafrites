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


class Api::Openresa::BookablesController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openresa::Bookable)

  api :GET, '/openresa/bookables/:id/available_quantity', 'Fetch quantity of bookable available (need checkin and checkout parameters)'
  def available_quantity
    @bookable = Openresa::Bookable.new(id: params[:id])
    backend_response_to_json  @bookable.available_quantity(user_context, params[:checkin], params[:checkout])
  end

  api :GET, '/openresa/bookables/:id/update_available_quantity', 'set new quantity of bookable available'
  def update_available_quantity
    @bookable = Openresa::Bookable.new(id: params[:id])
    backend_response_to_json  @bookable.update_available_quantity(user_context, params[:new_quantity])
  end

  def index
    if params[:partner_id]
      params[:filters] || params[:filters] = {}
      params[:filters]['partner_id'] = {field: 'partner_id',operator: '=',value:  params[:partner_id]}
    end
    super
  end

end
