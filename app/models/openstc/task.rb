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


class Openstc::Task
  include OpenObjectModel

  set_open_object_model 'project.task'

  @@available_fields = %w(href site1 actions absent_type_id category_id date_end date_start effective_hours equipment_ids id km name oil_price oil_qtity planned_hours project_id inter_desc remaining_hours state team_id total_hours user_id equipment_names inter_equipment agent_or_team_name date_deadline)
  attr_accessor *@@available_fields


  def available_vehicles(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = self.class.connection(user_context).execute(self.class.open_object_model, 'get_vehicules_authorized', self.id)
      BackendResponse.new(success: true, content: response)
    end
  end

  def available_equipments(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = self.class.connection(user_context).execute(self.class.open_object_model, 'get_materials_authorized', self.id)
      BackendResponse.new(success: true, content: response)
    end
  end

end

