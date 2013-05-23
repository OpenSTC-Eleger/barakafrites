require 'openerp'

class InterventionRequest
  @@model_name = 'openstc.ask'

  include ActiveModel::Model

  attr_accessor :site_details, :create_date, :partner_type_code, :write_uid, :refusal_reason, :partner_id, :id, :create_uid, :intervention_assignement_id, :people_name, :note, :current_date, :manager_id, :confirm_by_dst, :people_phone,:partner_address,:partner_email, :description, :state, :people_email, :partner_type, :actions, :name, :partner_service_id, :site2, :site3, :site1, :partner_phone, :service_id, :intervention_ids, :href


  def initialize(params = {})
    super(params)
    @href = "/#{self.class.to_s.underscore}/#{self.id}"
  end



  def self.where(user_context,filters = [])
    Openerp.search(user_context,@@model_name,filters)
  end

  def self.find(user_context, ids, fields = [])
    Openerp.read(user_context, @@model_name,ids,fields ).map do |ir|
      self.new ir
    end
  end

end
