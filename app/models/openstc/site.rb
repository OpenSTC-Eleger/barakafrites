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


class Openstc::Site
  include OpenObjectModel
  set_open_object_model 'openstc.site'

  @@available_fields = %w(complete_name id length name service_names service_ids site_parent_id surface type width actions internal_booking external_booking service_bookable_ids service_bookable_names partner_type_bookable_ids partner_type_bookable_names color product_id block_booking)

  @@available_fields.each do |field|
    attr_accessor field
  end

  @@related_fields = {"service_ids" => "Openstc::Department", "site_parent_id" => "Openstc::Site" }

end
