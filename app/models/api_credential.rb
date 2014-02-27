##
#
# Barakafrites helps openerp 6 to speak REST
#
#    Copyright (C) 2013  Siclic
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##


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
