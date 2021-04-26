class CreateSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :supplies do |t|
      t.string :code, null: false
      t.integer :weight, null: false
      t.references :grain_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
