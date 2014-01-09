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

  # Used as helper to sort response
  # @return [Array] Contains ordered objects
  def self.arrange_by_order(pager_order, response)
	  if pager_order && pager_order.size == 1 && !pager_order.first[:order].blank?
      field, order = pager_order.first[:order].split
      response = response.map do |e|
        if e.send(field.to_sym)
          e
        else
          e.send((field+'=').to_sym,'')
          e
        end
      end
      sort = case response.first.send(field.to_sym)
        when String
          response.sort_by { |e| e.send(field.to_sym).downcase }
        else
          response.sort_by { |e| e.send(field.to_sym) }
      end

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
          result = OpenObjectModel.arrange_by_order(pagination_and_ordering, result)
        end

        read_response.content = result
        read_response.success = true
        return read_response
      else
        return search_response
      end
    end

    # @return [OpenObject::BackendResponse] The number of records based on applied filters
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

    # Used to update one record
    # @param [Hash] user_context
    # @param [Fixnum] id
    # @param [Hash] attributes
    # @return [Boolean] true most of the time
    def write_one(user_context, id, attributes)
      self.write(user_context, [id.to_i], attributes)
    end

    # Used to delete one record
    # @param [Hash] user_context
    # @param [Fixnum] id
    # @return [Boolean] true always
    def unlink_one(user_context, id)
      self.unlink(user_context, [id.to_i])
    end

    # @param [Hash] user_context
    # @param [Hash] params
    # @return [Object] Created empty object with id filled in
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


    # @return [OpenObject::BackendResponse] 
    def fields(user_context, fields, metadata)
      OpenObject.rescue_xmlrpc_fault do
	print "GET FIELDS*****************"
        #fields = self.connection(user_context).execute(open_object_model, 'fields_get', fields)
	if metadata.has_key?("fields")
	  fields = metadata.fetch('fields')
	  fields.slice(fields)
	  fields.each do |field,value|
	    if value.has_key?('type')
	      value.keep_if {|k,v| k=="type"}
	    end
	  end
	end
	print fields
        OpenObject::BackendResponse.new(success: true, content: fields)
      end

    end

    def get_metadata(user_context, fields)
      OpenObject.rescue_xmlrpc_fault do
        print "GET METADATA*****************"
        #fields = self.connection(user_context).execute(open_object_model, 'fields_get', fields)
        metadata = self.connection(user_context).execute(open_object_model, 'getModelMetadata')
	metadata["filter"] = self.fields(user_context,metadata,fields)	
        OpenObject::BackendResponse.new(success: true, content: metadata)
      end

    end



  end


end
