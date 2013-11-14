class Openresa::Bookable
  include OpenObjectModel
  set_open_object_model 'product.product'

  @@available_fields = %w( id name href product_image)
  attr_accessor *@@available_fields

  def available_quantity(user_context, checkin, checkout)
    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::Booking.connection(user_context).execute(Openresa::Booking.open_object_model, 'get_prods_available_and_qty', checkin, checkout, [self.id.to_i])
      OpenObject::BackendResponse.new(success: true, content: response[self.id.to_s])
    end
  end

	# @param [Object] user_context
	# @param [Array] filters Array of Array containing ['fields','operator','value']
	# @param [Array] fields List of string of required fields names
	# @return [Array] Objects from the model
	# @note : overide of classMethod find_all to add custom filters
	def self.find_all(user_context, filters, fields, *pagination_and_ordering)

    new_filters = filters

    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::Bookable.connection(user_context).execute(Openresa::Bookable.open_object_model, 'get_bookables')
      OpenObject::BackendResponse.new(success: true, content: response)
      new_filters.push(['id','in',response])
    end

    return super(user_context,new_filters, fields, *pagination_and_ordering)
  end
end