module Openerp

  @@host = BarakafritesConfig.get[:openerp][:host]
  @@port = BarakafritesConfig.get[:openerp][:port]
  @@common = BarakafritesConfig.get[:openerp][:common]
  @@object = BarakafritesConfig.get[:openerp][:object]
  @@base = BarakafritesConfig.get[:openerp][:base]


end