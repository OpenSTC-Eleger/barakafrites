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


class Api::OpenObject::UsersController < Api::ResourceController
  resource_description do
    short 'Specific URIs to interact with/from users'
    formats ['json']
  end
  apipie_concern_subst({:controller_path => '/bar', :resource_id => 'foo'})

  include Api::ApiControllerModule
  self.resource_model = (::OpenObject::User )




  api :GET, '/open_object/users/:id/manageable_officers', 'Fetch agents the given user is able to manage'
  def manageable_officers
    @user = OpenObject::User.new(id: params[:id])
    backend_response_to_json  @user.manageable_officers(user_context)
  end

  api :GET, '/open_object/users/:id/manageable_teams', 'Fetch teams the given user is able to manage'
  def manageable_teams
    @user = OpenObject::User.new(id: params[:id])
    backend_response_to_json  @user.manageable_teams(user_context)
  end

  api :GET, '/open_object/users/:id/scheduled_tasks', 'Fetch all scheduled tasks for this user'
  def scheduled_tasks
    @filters = format_filters(params[:filters])
    @user = OpenObject::User.new(id: params[:id])
    backend_response_to_json @user.scheduled_tasks(user_context, @filters )
  end

  api :GET, '/open_object/users/:id/available_vehicles', 'Fetch vehicles the given user can use'
  def available_vehicles
    @user = OpenObject::User.new(:id => params[:id])
    backend_response_to_json @user.available_vehicles(user_context)
  end

  api :GET, '/open_object/users/:id/available_equipments', 'Fetch equipments the given user can use'
  def available_equipments
    @user = OpenObject::User.new(:id => params[:id])
    backend_response_to_json @user.available_equipments(user_context)
  end

end