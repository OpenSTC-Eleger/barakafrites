class OpenObject::PortableDocument
  include OpenObjectModel

  set_open_object_model 'ir.attachment'

  @@available_fields = %w(datas_fname datas name id)
  attr_accessor *@@available_fields

  def to_pdf
    Base64.decode64(self.datas).force_encoding(Encoding::UTF_8)
  end

end