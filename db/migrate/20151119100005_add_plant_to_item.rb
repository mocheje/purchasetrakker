class AddPlantToItem < ActiveRecord::Migration
  def change
    add_column :items, :plant_id, :integer
  end
end
