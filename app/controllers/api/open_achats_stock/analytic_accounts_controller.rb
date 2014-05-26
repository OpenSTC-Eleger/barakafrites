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


class Api::OpenAchatsStock::AnalyticAccountsController < Api::ResourceController
  include Api::ApiControllerModule
  self.resource_model=(::OpenAchatsStock::AnalyticAccount)

  def index
    params[:filters] = params[:filters] || {}
    params[:filters]['is_not_project0'] = '|'
    params[:filters]['is_not_project1'] = {field: 'code', operator: '!=', value: '3'}
    params[:filters]['is_not_project2'] = {field: 'code', operator: '=', value: false}
    
    params[:filters]['is_not_project3'] = '|'
    params[:filters]['is_not_project4'] = {field: 'type', operator: '!=', value: 'view'}
    params[:filters]['is_not_project5'] = {field: 'type', operator: '=', value: false}
    
    params[:filters]['is_not_project6'] = '|'
    params[:filters]['is_not_project7'] = {field: 'parent_id.code', operator: '!=', value: '3'}
    params[:filters]['is_not_project8'] = {field: 'parent_id', operator: '=', value: false}

  	super
  end

end
