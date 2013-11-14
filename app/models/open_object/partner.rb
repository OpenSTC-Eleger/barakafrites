class OpenObject::Partner
  include OpenObjectModel

  set_open_object_model 'res.partner'

  @@available_fields = %w(address category_id contract_ids id email name phone service_id task_ids technical_service_id technical_site_id title type_id user_id property_product_pricelist)
  attr_accessor *@@available_fields

  def get_bookables(user_context)
  	
    OpenObject.rescue_xmlrpc_fault do
      response = Openresa::Bookable.connection(user_context).execute(Openresa::Bookable.open_object_model, 'get_bookables', false, self.id.to_i)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

  def get_bookables_pricing(user_context, prodAndQties, checkin, checkout)
    OpenObject.rescue_xmlrpc_fault do
      response = OpenObject::Partner.connection(user_context).execute(OpenObject::Partner.open_object_model, 'get_bookable_prices', self.id.to_i,prodAndQties,checkin,checkout)
      OpenObject::BackendResponse.new(success: true, content: response)
    end
  end

end