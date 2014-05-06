class AddExpiresToApiCredential < ActiveRecord::Migration
  def change
    add_column :api_credentials, :expire, :boolean, default: true
  end
end
