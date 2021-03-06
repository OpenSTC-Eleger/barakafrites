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


class Api::Openstc::TasksController < Api::ResourceController
  resource_description do
    short 'Specific URIs to interact with/from tasks'
  end
  include Api::ApiControllerModule
  self.resource_model=(::Openstc::Task)

  api :GET, '/openstc/tasks/:id/available_vehicles', 'Fetch available vehicles to complete this task '
  def available_vehicles
    @task_id = params[:id]
    backend_response_to_json Openstc::Task.new(:id => @task_id).available_vehicles(user_context)
  end


  api :GET, '/openstc/tasks/:id/available_equipments', 'Fetch available equipments to complete this task'
  def available_equipments
    @task_id = params[:id]
    backend_response_to_json Openstc::Task.new(:id => @task_id).available_equipments(user_context)
  end

end