class Api::OpenObject::MetaDatasController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::MetaData )

  api :GET, '/open_object/meta_datas/:id/filters', 'Fetch filters available for current user'
  def filters
    @metadata = OpenObject::MetaData.new(id: params[:id])
    backend_response_to_json  @metadata.filters(user_context)
  end



end

