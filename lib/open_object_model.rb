module OpenObjectModel
  def self.included(base)
    base.class_eval do
      include ActiveModel::Model
      include Openerp

      attr_accessor :href

      def initialize(attributes = {})
        super
        @href = "/#{self.class.to_s.underscore.pluralize}/#{id}"
      end

    end
    base.extend ClassMethods
  end


  module ClassMethods

    # @param [Object] user_context
    # @param [Array] filters Array of Array containing ['fields','operator','value']
    # @param [Array] fields List of string of required fields names
    # @return [Array] Objects from the model
    def find_all(user_context, filters = [], fields = [])
      search_response = self.search(user_context, filters)
      ids = search_response.content
      result = []
      if ids.size > 0
        read_response = self.read(user_context, ids, fields)
        data = read_response.content
        data.each do |e|
          result << self.new(e)
        end
       end
      result
      read_response.content = result
      read_response
    end


    # @return [Object] instance of the model or nil
    def find_one(user_context, id, fields = [])
      read_response = self.read(user_context, [id.to_i], fields)

      if read_response.content
        read_response.content= self.new(read_response.content.first)
      end
      read_response
    end

    def create_and_return(user_context,params)
      create_response = self.create(user_context,params)
      if create_response.success
        create_response.content = self.new(:id => create_response.content)
      end
      create_response
    end


  end


end
