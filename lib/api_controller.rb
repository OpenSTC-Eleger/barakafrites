module ApiController

  def self.included(base)
    base.extend ClassMethods
  end



  def format_filters(params_filter)
    filters = if params_filter.size > 0
                params_filter.map do |filter|
                  [filter['field'], filter['operator'], filter['value']]
                end
              else
                params_filter
              end
  end

  def index
    @fields = params[:fields] || []
    @filters = params[:filters] || []
    @collection = self.class.maping_model.find_all(user_context, format_filters(@filters), @fields)
    backend_response_to_json @collection
  end

  def create
    @resource = params[self.class.resource_param]
    @create = self.class.maping_model.create(user_context, @resource)
    backend_response_to_json @create
  end

  def show
    @resource = self.class.maping_model.find_one(user_context, params[:id], params[:fields])
    backend_response_to_json @resource
  end

  def update
    @attributes = params[self.class.resource_param]
    @update = self.class.maping_model.write_one(user_context, params[:id], @attributes)
    backend_response_to_json @update
  end



  module ClassMethods

    def maping_model
      @maping_model
    end

    def maping_model=(klass)
      @maping_model = klass
    end

    def resource_param
      @maping_model.name.split('::').last.underscore
    end


  end

end