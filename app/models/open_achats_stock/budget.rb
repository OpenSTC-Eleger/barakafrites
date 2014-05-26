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


class OpenAchatsStock::Budget
  include OpenObjectModel
  set_open_object_model 'crossovered.budget'

  @@available_fields = %w( id name href service_id openstc_practical_amount planned_amount date_from date_to state actions new_name new_date_from new_date_to validate_note done_note cancel_note)

  attr_accessor *@@available_fields
  @@related_fields = {"service_id" => "Openstc::Department"}

end


