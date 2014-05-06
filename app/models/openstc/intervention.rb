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


class Openstc::Intervention
  include OpenObjectModel
  set_open_object_model 'project.project'
  @@available_fields = %w(id name description tasks state service_id site1 site_details date_deadline planned_hours effective_hours tooltip progress_rate overPourcent actions ask_id create_uid create_date total_hours has_equipment equipment_id)

  @@available_fields.each do |field|
    attr_accessor field
  end

  @@related_fields = {"service_id" => "Openstc::Department", "site1" => "Openstc::Site", "equipment_id" => "Openstc::Equipment"}

end
