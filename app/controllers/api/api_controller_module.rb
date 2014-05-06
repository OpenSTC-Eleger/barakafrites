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


module Api::ApiControllerModule

  def self.included(base)
    base.extend ClassMethods
  end
  extend Apipie::DSL::Concern

  # @param [the params hash] params_filter
  # @return [Array] params filtered and formated for the OpenObject request
  def format_filters(params_filter)
    if params_filter
      raise ArgumentError.new('Filter parameters must be Hash') unless params_filter.kind_of?(Hash)
      filters = params_filter.map do |index, filter|
        case filter.size
          when 1
            filter
	  when 3
            filter.map { |k, v| v if v }
          else
            next
        end
      end
    else
      []
    end
  end

  def remove_nils(hash)
    hash.delete_if {|k,v| v.nil? }
  end



  api :GET, '/:controller_path', 'List :resource_id'
  def index

    @fields = params[:fields] || []
    @filters = params[:filters]

    if request.head?
      @count = self.class.resource_model.count(user_context, format_filters(@filters)).content
      @metadata = self.class.resource_model.get_metadata(user_context).content
      #@count = @metadata["count"]
      @fields = @metadata["fields"]
      head :ok, { "Content-Range" => "#{self.class.resource_model.name} #{0}-#{0}/#{@count}", "Model-Fields" => "#{@fields.to_json}", "Model-Id" => "#{@metadata['model_id']}" }
    else

      pagination_and_sorting = ApplicationHelper.compute_pagination_sorting(params)
      @collection = self.class.resource_model.find_all(user_context, format_filters(@filters), @fields, *pagination_and_sorting)
      backend_response_to_json @collection
    end
  end

  api :POST, '/:controller_path', 'Creates :resource_id'
  def create
    @resource = remove_nils(params[self.class.resource_param])
    @create = self.class.resource_model.create(user_context, @resource)
    backend_response_to_json @create
  end

  def show
    @resource = self.class.resource_model.find_one(user_context, params[:id], params[:fields])
    backend_response_to_json @resource
  end

  def update
    @attributes = remove_nils(params[self.class.resource_param])
    @update = self.class.resource_model.write_one(user_context, params[:id], @attributes)
    backend_response_to_json @update
  end

  def destroy
    @destroy = self.class.resource_model.unlink_one(user_context, params[:id])
    backend_response_to_json @destroy
  end

  module ClassMethods

    def resource_model
      @resource_model
    end

    def resource_model=(klass)
      @resource_model = klass
    end

    def resource_param
      @resource_model.name.split('::').last.underscore
    end

  end

end
