class Openresa::Bookable
  include OpenObjectModel
  set_open_object_model 'product.product'

  @@available_fields = %w( id name href )
  attr_accessor *@@available_fields

end