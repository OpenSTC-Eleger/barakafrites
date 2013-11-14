class Api::OpenObject::PartnersController < Api::ResourceController
  include Api::ApiControllerModule

  self.resource_model = (::OpenObject::Partner )

  api :GET, '/openresa/partners/:id/get_bookables', 'Fetch bookables available for current partner'
  def manageable_officers
    @partner = OpenObject::Partner.new(id: params[:id])
    backend_response_to_json  @partner.get_bookables(user_context)
  end

  api :GET, '/openresa/partners/:id/get_bookables_pricing', 'Fetch bookables pricing, need parameters : [[prod_id,qty],...] and checkin,checkout; for current partner'
  def get_bookables_pricing
    @partner = OpenObject::Partner.new(id: params[:id])
    prodAndQties = params[:prodAndQties]
    @newProdAndQties = []
    prodAndQties.map do |index, val|
    	val.each do |key,v|
    		val[key] = v.to_i
    	end
    	@newProdAndQties.push(val)
    end
    backend_response_to_json  @partner.get_bookables_pricing(user_context, @newProdAndQties, params[:checkin], params[:checkout])
  end

end