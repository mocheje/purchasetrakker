class ItemInventory < ActiveRecord::Base
  attr_accessible :item_id, :quantity, :station_id
  belongs_to :station
  belongs_to :item
end
