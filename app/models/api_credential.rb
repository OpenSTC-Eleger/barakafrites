class ApiCredential < ActiveRecord::Base
  before_create :generate_access_token

  attr_accessible :access_token, :open_object_dbname, :open_object_uid, :open_object_pwd

  def open_object_context
    {uid: open_object_uid, pwd: open_object_pwd, dbname: open_object_dbname}
  end

  # Destroy all credentials older than Time.now + BarakafritesConfig.get[:credential_expiration_hours]
  # @return [Fixnum] the expired session count
  def self.process_expiration
    records = self.where("created_at <= :datetime", {:datetime => (Time.now - BarakafritesConfig.get[:credential_expiration_hours].hours) })
    count = records.count
    logger.info("Processing session expiration, deleting #{count} records")
    records.destroy_all
  end

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

end
