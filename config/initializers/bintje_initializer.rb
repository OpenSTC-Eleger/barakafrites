module OpenObject

  @@host = BarakafritesConfig.get[:open_object][:host]
  @@port = BarakafritesConfig.get[:open_object][:port]
  @@common = BarakafritesConfig.get[:open_object][:common]
  @@object = BarakafritesConfig.get[:open_object][:object]
  @@base = BarakafritesConfig.get[:open_object][:base]

end

OpenObject.logger = Rails.logger
