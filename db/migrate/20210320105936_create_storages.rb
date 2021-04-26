class CreateStorages < ActiveRecord::Migration[6.0]
  def change
    create_table :storages do |t|
      t.string :name, null: false
      t.integer :capacity, null: false
      t.integer :fullness, null: false, default: 0
      t.references :grain_type, null: true, foreign_key: true

      t.timestamps
    end
  end
end
