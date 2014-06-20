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


class Api::OpenAchatsStock::PartialPickingsController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::OpenAchatsStock::PartialPicking)

  api :GET, '/open_achats_stock/partial_pickings/:id/perform', 'Perform a partial picking into the backend'
  def perform
    @picking = OpenAchatsStock::PartialPicking.new(id: params[:id])
    backend_response_to_json  @picking.do_partial(user_context)
  end

  api :GET, '/open_achats_stock/purchases/:purchase_id/partial_pickings', 'create a partial picking into the backend and return it, if resource fetched from a purchase'
  def index
    purchase_id = params[:purchase_id] || false
    if purchase_id && !request.head?
      @purchase = OpenAchatsStock::Purchase.new(id: params[:purchase_id])
      picking_id =  @purchase.create_partial_picking(user_context)
      if picking_id
        params[:filters] ||= {}
        params[:filters] = {only_this_id: {field: 'id', operator: '=', value: picking_id}}
      end
    end

    super
  end

end
