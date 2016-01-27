class AddStationReferenceToDepartment < ActiveRecord::Migration
  def change
    rename_column :departments, :station, :station_id
    change_column :departments, :station_id, :integer
  end
end
