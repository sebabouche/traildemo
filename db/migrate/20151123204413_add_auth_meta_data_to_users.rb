class AddAuthMetaDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_meta_data, :text
    remove_column :users, :password_digest
    remove_column :users, :confirmation_token
  end
end
