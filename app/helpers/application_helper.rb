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


module ApplicationHelper
  def self.compute_pagination_sorting(params)
    pagination_and_sorting = Array.new

    sorting = params[:sort]
    pagination = params.select { |k, v| %w(offset limit).include?(k) && !v.nil? }.inject({}) { |h, (k, v)| h[k.to_sym] = v.to_i; h }
    pagination_and_sorting << pagination unless pagination.empty?
    pagination_and_sorting << {order: sorting} unless sorting.nil?
    pagination_and_sorting = [pagination_and_sorting.inject({}) { |h, el| h.merge!(el); h }] unless pagination_and_sorting.empty?
    return pagination_and_sorting
  end
  
end
