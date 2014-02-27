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


class OpenObject::Menu
  include OpenObjectModel
  set_open_object_model 'ir.ui.menu'


  @@available_fields = %w(child_id name href complete_name parent_id id path submenu)

  @@available_fields.each { |field| attr_accessor field}

  def self.fetch(user_context,root_name = BarakafritesConfig.get[:root_menu])
    OpenObject.rescue_xmlrpc_fault do
      response = OpenObject::User.connection(user_context).execute(OpenObject::User.open_object_model, 'get_menu_formatted')
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end


  def self.recursive_fetch(user_context,id)
    item = self.find_one(user_context, id,['child_id','name','complete_name','parent_id' ]).content
    item.path = build_path_from_string(item)
    item.submenu = Array.new
    case item.child_id.try :count
      when nil
        item
      when 0
        item
      else
        item.child_id.each do |c|
          item.submenu << recursive_fetch(user_context,c)
        end
        item
    end
  end




  def self.build_path_from_string(menu_item)
    case menu_item.complete_name
      when nil
        ''
      else
        menu_item.complete_name.split('/').map(&:parameterize).join('/')
    end
  end



end