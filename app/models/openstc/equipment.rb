class Openstc::Equipment
  include OpenObjectModel

  @@available_fields = %w( id name href )
  attr_accessor *@@available_fields

end