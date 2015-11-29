class RenamePlantIdToStationIdInItem < ActiveRecord::Migration
  def up
    rename_column :items, :plant_id, :station_id
  end

  def down
    rename_column :items, :station_id, :plant_id
  end
end
