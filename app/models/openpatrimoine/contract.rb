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


class Openpatrimoine::Contract
  include OpenObjectModel
  set_open_object_model 'openstc.patrimoine.contract'

  @@available_fields = %w( id name href actions date_start_order date_end_order internal_inter technical_service_id supplier_id provider_name patrimoine_is_equipment equipment_id site_id patrimoine_name state description deadline_delay type_renewal category_id contract_line contract_line_names delay_passed warning_delay state_order cancel_reason remaining_delay new_description new_date_start_order new_date_end_order)
  attr_accessor *@@available_fields
  
  @@related_fields = {"category_id" => "Openpatrimoine::ContractType", "site_id" => "Openstc::Site", "equipment_id" => "Openstc::Equipment", "technical_service_id" => "Openstc::TechnicalDepartment",
      "supplier_id" => "OpenObject::Supplier", "contract_line" => "Openpatrimoine::ContractLine"}
end
