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


class Openstc::TaskSchedule
  include OpenObjectModel

  @@available_fields = %w(task_id start_working_time end_working_time start_lunch_lime end_lunch_time start_dt team_mode calendar_id)
  attr_accessor *@@available_fields

  def self.create(user_context, args = {})
    OpenObject.rescue_xmlrpc_fault do
      response = self.connection(user_context).execute('project.task', 'planTasks', [args['task_id']], args.except('task_id'))
      BackendResponse.new({success: true, content: response})
    end
  end

end