class ApiCredential < ActiveRecord::Base
  before_create :generate_access_token

  attr_accessible :access_token, :openerp_dbname, :openerp_uid, :openerp_pwd

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

end
