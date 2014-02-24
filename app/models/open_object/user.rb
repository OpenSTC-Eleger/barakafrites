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


class OpenObject::User
  include OpenObjectModel
  set_open_object_model 'res.users'

  @@available_fields = %w(complete_name contact_id context_lang context_tz date firstname groups_id id isDST isManager lastname login name phone service_id service_ids tasks team_ids user_email actions current_group openresa_group service_names isResaManager)

  @@available_fields.each do |field|
    attr_accessor field
  end

  def self.authenticate(dbname, login, password)
    OpenObject.login(dbname, login, password).content
  end


  def manageable_officers(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = OpenObject::User.connection(user_context).execute(OpenObject::User.open_object_model, 'get_manageable_officers', self.id.to_i)
      OpenObject::BackendResponse.new(success: true, content: response)
    end


  end

  def manageable_teams(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = OpenObject::User.connection(user_context).execute(OpenObject::User.open_object_model, 'get_manageable_teams', self.id.to_i)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

  def scheduled_tasks(user_context, filters)
    OpenObject.rescue_xmlrpc_fault do
      response = OpenObject::User.connection(user_context).execute(Openstc::Task.open_object_model, 'getUserTasksList', filters)
      OpenObject::BackendResponse.new(success: true , content: response)
    end
  end

  def available_vehicles(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = Openstc::Task.connection(user_context).execute(Openstc::Task.open_object_model, 'get_vehicules_authorized', false)
      BackendResponse.new(success: true, content: response)
    end
  end

  def available_equipments(user_context)
    OpenObject.rescue_xmlrpc_fault do
      response = Openstc::Task.connection(user_context).execute(Openstc::Task.open_object_model, 'get_materials_authorized', false)
      BackendResponse.new(success: true, content: response)
    end
  end

end
