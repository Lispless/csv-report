class AddStatusToResident < ActiveRecord::Migration[8.0]
  def change
    add_column :residents, :status, :string
  end
end
