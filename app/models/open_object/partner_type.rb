class OpenObject::PartnerType
  include OpenObjectModel

  set_open_object_model 'openstc.partner.type'

  @@available_fields = %w(claimers code id name actions)
  attr_accessor *@@available_fields

end