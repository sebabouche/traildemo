class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.text :name
      t.text :description

      t.timestamps null: false
    end
  end
end
