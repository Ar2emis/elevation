class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.integer :amount, null: false
      t.references :grain_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
