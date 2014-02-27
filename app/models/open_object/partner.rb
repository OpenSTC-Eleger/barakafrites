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


class OpenObject::Partner
  include OpenObjectModel

  set_open_object_model 'res.partner'

  @@available_fields = %w(address category_id contract_ids id email name phone service_id task_ids technical_service_id technical_site_id title type_id user_id property_product_pricelist)
  attr_accessor *@@available_fields

  def get_bookables(user_context)
  	
    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::Bookable.connection(user_context).execute(Openresa::Bookable.open_object_model, 'get_bookables', self.id.to_i)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

  def get_bookables_pricing(user_context, prodAndQties, checkin, checkout)
    OpenObject.rescue_xmlrpc_fault do
      response = OpenObject::Partner.connection(user_context).execute(OpenObject::Partner.open_object_model, 'get_bookable_prices', self.id.to_i,prodAndQties,checkin,checkout)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

end
