class CreateItemInventories < ActiveRecord::Migration
  def change
    create_table :item_inventories do |t|
      t.integer :item_id
      t.integer :quantity
      t.integer :station_id

      t.timestamps
    end
  end
end
