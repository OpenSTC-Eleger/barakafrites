class OpenObject::PartnerAddress
  include OpenObjectModel

  set_open_object_model 'res.partner.address'

  @@available_fields = %w(email function id livesIn mobile name partner_id phone street type user_id zip)
  attr_accessor *@@available_fields

end