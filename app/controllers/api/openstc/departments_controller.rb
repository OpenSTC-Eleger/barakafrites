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


class Api::Openstc::DepartmentsController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::Openstc::Department)
  
  api :GET, '/openstc/departments/:id/users', 'Fetch agents on the department '
  def users
    @department_id = params[:id]
    @base_filter = ['service_ids.id','=',@department_id]
    @filters = format_filters(params[:filters]) || []
    @filters.push(@base_filter)
    pagination_and_sorting = ApplicationHelper.compute_pagination_sorting(params)
    backend_response_to_json OpenObject::User.find_all(user_context, @filters, params[:fields], *pagination_and_sorting)
  end
  
  api :GET, '/openstc/departments/:department_id/teams', 'Fetch teams on the department '
    def teams
      @department_id = params[:id]
      @base_filter = ['service_ids.id','=',@department_id]
      @filters = format_filters(params[:filters]) || []
      @filters.push(@base_filter)
      pagination_and_sorting = ApplicationHelper.compute_pagination_sorting(params)
      backend_response_to_json Openstc::Team.find_all(user_context, @filters, params[:fields], *pagination_and_sorting)
    end
    
end