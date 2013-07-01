class RenamedOpenerpIntoOpenObject < ActiveRecord::Migration
  def up
    change_table :api_credentials do |table|
      table.remove :openerp_uid
      table.integer :open_object_uid
      table.remove :openerp_dbname
      table.string :open_object_dbname
      table.remove :openerp_pwd
      table.string :open_object_pwd
    end
  end

  def down
  end
end
