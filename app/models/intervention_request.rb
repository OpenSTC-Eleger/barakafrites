require 'openerp'

class InterventionRequest

  def self.where(user_context,filters = [])
    Openerp.search(user_context,'openstc.ask',filters)
  end

end
