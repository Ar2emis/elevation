class CreateGrainTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :grain_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
