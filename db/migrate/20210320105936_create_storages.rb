class CreateStorages < ActiveRecord::Migration[6.0]
  def change
    create_table :storages do |t|
      t.string :name, null: false
      t.integer :capacity, null: false

      t.timestamps
    end
  end
end
