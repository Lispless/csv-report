class CreateResidents < ActiveRecord::Migration[8.0]
  def change
    create_table :residents do |t|
      t.string :name
      t.date :move_in
      t.date :move_out
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
