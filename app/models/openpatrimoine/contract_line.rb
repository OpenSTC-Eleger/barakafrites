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


class Openpatrimoine::ContractLine
  include OpenObjectModel, ApiModelRecurrenceModule
  set_open_object_model 'openstc.task.recurrence'

  @@available_fields = %w( id name href is_team agent_id team_id internal_inter technical_service_id planned_hours task_categ_id supplier_cost recur_periodicity recur_week_monday recur_week_tuesday recur_week_wednesday recur_week_thursday recur_week_friday recur_week_saturday recur_week_sunday recur_month_type recur_month_absolute recur_month_relative_weight recur_month_relative_day recur_length recur_type date_start date_end recur_occurrence_nb occurrence_ids recurrence partner_id)
  attr_accessor *@@available_fields
  
  #@note: sry for the fault 'TaskCategorie', but Ruby is not enough smart to know that plurial of category is categories ^^
  @@related_fields = {"agent_id" => "Openstc::Departments:::technical_service_id::Users", "team_id" => "Openstc::Departments:::technical_service_id::Teams",
  "task_categ_id" => "Openstc::TaskCategorie"}
end