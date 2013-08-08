module OpenObjectModel

  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      include ActiveModel::Model
      include OpenObject

      attr_accessor :href, :id, :name

      class << self
        alias_method_chain :read, :fields
      end

      def initialize(attributes = {})
        super
        @href = "/#{self.class.to_s.underscore.pluralize}/#{id}"
      end

    end

  end

  def self.arrange_by_order(pager_order, response)
    if pager_order && pager_order.size == 1 && !pager_order.first[:order].blank?
      field, order = pager_order.first[:order].split
      sort = response.sort_by { |e| e.send(field.to_sym) }
      if order == 'ASC'
        sort
      else
        sort.reverse
      end
    else
      response
    end
  end


  module ClassMethods

    # @param [Object] user_context
    # @param [Array] filters Array of Array containing ['fields','operator','value']
    # @param [Array] fields List of string of required fields names
    # @return [Array] Objects from the model
    def find_all(user_context, filters, fields, *pagination_and_ordering)

      search_response = self.search(user_context, filters, *pagination_and_ordering)
      ids = search_response.content
      result = []
      if search_response.success
        read_response = OpenObject::BackendResponse.new
        if ids && ids.size > 0
          read_response = self.read(user_context, ids, fields)
          data = read_response.content
          data.each do |e|
            result << self.new(e)
          end
        end
        result = OpenObjectModel.arrange_by_order(pagination_and_ordering, result)
        read_response.content = result
        read_response.success = true
        return read_response
      else
        return search_response
      end
    end

    def count(user_context, filters)
      OpenObject.rescue_xmlrpc_fault do
        count = self.connection(user_context).execute(open_object_model, 'search_count', filters)
        OpenObject::BackendResponse.new(success: true, content: count)
      end

    end


    # @return [Object] instance of the model or nil
    def find_one(user_context, id, fields = [])
      read_response = self.read(user_context, [id.to_i], fields)

      if read_response.content
        read_response.content= self.new(read_response.content.first)
      end
      read_response
    end


    def write_one(user_context, id, attributes)
      self.write(user_context, [id.to_i], attributes)
    end

    def unlink_one(user_context, id)
      self.unlink(user_context, [id.to_i])
    end

    def create_and_return(user_context, params)
      create_response = self.create(user_context, params)
      if create_response.success
        create_response.content = self.new(:id => create_response.content)
      end
      create_response
    end


    # Called in Alias Method Chain, see around line 12
    # Set fields on Bintje's OpenObject.read
    #
    # @param [Hash] user_context
    # @param [Array] ids
    # @param [Array][Fixnum] fields If given fields are not referenced in model class, remove them. If empty replace with model's fields
    # Then call the original read method with completed fields parameters
    # @return [Array] Whatever OpenObject.read return
    def read_with_fields(user_context, ids, fields)
      available_fields = class_variable_get(:@@available_fields)
      fields.nil? && fields = available_fields
      valid_fields = available_fields & fields
      valid_fields.empty? && valid_fields = available_fields
      Rails.logger.debug("Read with fields #{valid_fields}")
      read_without_fields(user_context, ids, valid_fields)
    end


  end


end
