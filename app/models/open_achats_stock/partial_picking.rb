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


class OpenAchatsStock::PartialPicking
  include OpenObjectModel
  set_open_object_model 'stock.partial.picking'

  @@available_fields = %w( id href date move_ids)

  @@related_fields = {"move_ids" => "OpenAchatsStock::PartialPickingLine"}

  attr_accessor *@@available_fields

	def do_partial(user_context)
		OpenObject.rescue_xmlrpc_fault do
			response = OpenAchatsStock::PartialPicking.connection(user_context).execute(OpenAchatsStock::PartialPicking.open_object_model, 'do_partial', [self.id.to_i])
			OpenObject::BackendResponse.new(success: true, content: response)
		end
	end
end