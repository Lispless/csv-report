class CreateUnits < ActiveRecord::Migration[8.0]
  def change
    create_table :units do |t|
      t.integer :unit_number
      t.string :floor_plan

      t.timestamps
    end
  end
end
