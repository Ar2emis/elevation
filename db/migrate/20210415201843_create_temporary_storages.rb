class CreateTemporaryStorages < ActiveRecord::Migration[6.0]
  def change
    create_table :temporary_storages do |t|
      t.integer :amount, default: 0
      t.references :grain_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
