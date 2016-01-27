class AddStationIdToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :station_id, :integer
  end
end
