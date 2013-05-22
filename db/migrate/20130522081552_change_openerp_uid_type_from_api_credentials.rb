class ChangeOpenerpUidTypeFromApiCredentials < ActiveRecord::Migration
  def change
    change_table :api_credentials do |table|
      table.remove :openerp_uid
      table.integer :openerp_uid
      table.index :access_token
    end
  end
end
