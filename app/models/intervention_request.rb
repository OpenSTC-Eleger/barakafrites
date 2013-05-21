require 'openerp'

class InterventionRequest

  def self.where(user_context,filters=[])
    Rails.logger.info("request context : #{user_context}")
    Openerp.search(user_context,'openstc.ask',filters)
  end

end
