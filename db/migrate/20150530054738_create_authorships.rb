class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.integer :user_id
      t.integer :thing_id
      t.integer :confirmed

      t.timestamps
    end
  end
end
