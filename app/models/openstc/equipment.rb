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


class Openstc::Equipment
  include OpenObjectModel

  set_open_object_model  'openstc.equipment'
  @@available_fields = %w( id name href maintenance_service_ids internal_use service_ids immat marque usage type cv time km energy_type length_amort purchase_price default_code categ_id service_names maintenance_service_names complete_name product_product_id warranty_date purchase_date hour_price built_date internal_booking external_booking service_bookable_ids service_bookable_names partner_type_bookable_ids partner_type_bookable_names qty_available color block_booking)
  attr_accessor *@@available_fields

end
