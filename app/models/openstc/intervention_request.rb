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


class Openstc::InterventionRequest
  include OpenObjectModel
  set_open_object_model 'openstc.ask'
  
  @@available_fields = %w(actions belongsToAssignement tooltip belongsToService id name belongsToSite create_date create_uid date_deadline description id intervention_assignement_id intervention_ids manager_id name note partner_address partner_email partner_id partner_name partner_phone partner_service_id partner_type partner_type_code people_email people_name people_phone refusal_reason service_id site1 site_details state write_uid has_equipment equipment_id is_citizen)


  attr_accessor *@@available_fields
  

  @@related_fields = {"service_id" => "Openstc::Department", "site1" => "Openstc::Site", "equipment_id" => "Openstc::Equipment", "intervention_assignement_id" => "Openstc::InterventionCategory",
			"partner_id" => "OpenObject::Partner" }

end

