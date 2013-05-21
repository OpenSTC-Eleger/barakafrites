class CreateApiCredentials < ActiveRecord::Migration
  def change
    create_table :api_credentials do |t|
      t.string :access_token
      t.string :openerp_uid
      t.string :openerp_pwd
      t.string :openerp_dbname
      t.timestamps
    end
  end
end
