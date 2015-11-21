class CreateCacheVersions < ActiveRecord::Migration
  def change
    create_table :cache_versions do |t|
      t.string :name
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
