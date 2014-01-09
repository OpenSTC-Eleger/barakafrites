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
      @myFields = self.class.resource_model.fields(user_context, @fields).content
      head :ok, "Content-Range" => "#{self.class.resource_model.name} #{0}-#{0}/#{@count}"
    else

      pagination_and_sorting = Array.new

      sorting = params[:sort]
      pagination = params.select { |k, v| %w(offset limit).include?(k) && !v.nil? }.inject({}) { |h, (k, v)| h[k.to_sym] = v.to_i; h }
      pagination_and_sorting << pagination unless pagination.empty?
      pagination_and_sorting << {order: sorting} unless sorting.nil?
      pagination_and_sorting = [pagination_and_sorting.inject({}) { |h, el| h.merge!(el); h }] unless pagination_and_sorting.empty?
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
