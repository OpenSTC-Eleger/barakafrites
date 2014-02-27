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


class Openresa::Bookable
  include OpenObjectModel
  set_open_object_model 'product.product'

  @@available_fields = %w( id name href product_image type_prod color qty_available categ_id block_booking)
  attr_accessor *@@available_fields

  def available_quantity(user_context, checkin, checkout)
    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::Booking.connection(user_context).execute(Openresa::Booking.open_object_model, 'get_prods_available_and_qty', checkin, checkout, [self.id.to_i])
      OpenObject::BackendResponse.new(success: true, content: response[self.id.to_s])
    end
  end

  def update_available_quantity(user_context, new_quantity)
    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::Bookable.connection(user_context).execute(Openresa::Bookable.open_object_model, 'openbase_change_stock_qty', self.id.to_i, new_quantity)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

  # @param [Object] user_context
  # @param [Array] filters Array of Array containing ['fields','operator','value']
  # @param [Array] fields List of string of required fields names
  # @return [Array] Objects from the model
  # @note : overide of classMethod find_all to add custom filters

  def self.find_all(user_context, filters, fields, *pagination_and_ordering)
    if partner_domain = filters.select { |e| e.first == 'partner_id' }.flatten
    filters.delete(partner_domain)

    partner_id = partner_domain.last.to_i

    partner_id ||= false
    new_filters = filters
    end

    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::Bookable.connection(user_context).execute(Openresa::Bookable.open_object_model, 'get_bookables', partner_id)
      OpenObject::BackendResponse.new(success: true, content: response)
      new_filters.push(['id','in',response])
    end

    return super(user_context,new_filters, fields, *pagination_and_ordering)
  end
end
