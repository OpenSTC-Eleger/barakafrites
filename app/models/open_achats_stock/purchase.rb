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


class OpenAchatsStock::Purchase
  include OpenObjectModel
  set_open_object_model 'purchase.order'

  @@available_fields = %w( id name href date_order description service_id partner_id amount_total state validation validation_order actions check_dst check_elu user_id attach_invoices attach_not_invoices attach_waiting_invoice_ids engage_to_treat account_analytic_id)

  @@related_fields = {"service_id" => "Openstc::Department", "partner_id" => "OpenObject::Supplier", "account_analytic_id" => "OpenAchatsStock::BudgetLine"}

  attr_accessor *@@available_fields

end
