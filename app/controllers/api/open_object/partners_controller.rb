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


class Api::OpenObject::PartnersController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::Partner )

  api :GET, '/openresa/partners/:id/get_bookables', 'Fetch bookables available for current partner'
  def manageable_officers
    @partner = OpenObject::Partner.new(id: params[:id])
    backend_response_to_json  @partner.get_bookables(user_context)
  end

  api :GET, '/openresa/partners/:id/get_bookables_pricing', 'Fetch bookables pricing, need parameters : [[prod_id,qty],...] and checkin,checkout; for current partner'
  def get_bookables_pricing
    @partner = OpenObject::Partner.new(id: params[:id])
    prodAndQties = params[:prodAndQties]
    @newProdAndQties = []
    prodAndQties.map do |index, val|
    	val.each do |key,v|
    		val[key] = v.to_i
    	end
    	@newProdAndQties.push(val)
    end
    backend_response_to_json  @partner.get_bookables_pricing(user_context, @newProdAndQties, params[:checkin], params[:checkout])
  end

end