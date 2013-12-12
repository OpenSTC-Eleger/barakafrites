class Api::OpenObject::PortableDocumentsController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::PortableDocument )

  def show
    remote_data = ::OpenObject::PortableDocument.read(user_context, [params[:id].to_i],[])
    if remote_data.content.size > 0
      document = OpenObject::PortableDocument.new(remote_data.content.first)
      send_data(document.to_pdf, filename: document.datas_fname, type: 'application/pdf')
    else
      head 404
    end

  end

end