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


class Api::OpenObject::PortableDocumentsController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::PortableDocument )

  def show
    remote_data = ::OpenObject::PortableDocument.read(user_context, [params[:id].to_i],[])
    if remote_data.content.size > 0
      document = OpenObject::PortableDocument.new(remote_data.content.first)
      send_data(document.to_pdf, filename: document.datas_fname, type: 'application/pdf')
    else
      head 404
    end

  end

end