class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :thing, index: true, foreign_key: true
      t.boolean :confirmed

      t.timestamps null: false
    end
  end
end
