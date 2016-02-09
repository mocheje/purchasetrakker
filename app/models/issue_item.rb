class IssueItem < ActiveRecord::Base
  attr_accessible :comment, :item_id, :quantity, :request_id, :issue_id
  belongs_to :issue
  belongs_to :item
  validates :item_id, :quantity, presence: true
  after_create :update_inventory

      def update_inventory
        item = self.item_id
        quantity = self.quantity
        station = self.issue.request.user.department.station_id
        @item_inventory = ItemInventory.find_by_item_id_and_station_id(item, station)
        if @item_inventory #found at leat one record
          n_quantity = @item_inventory.quantity - quantity
          @item_inventory.update_attributes({:quantity => n_quantity})
        else
          ItemInventory.create({:item_id => item, :quantity => -(quantity), :station_id => station})
        end
      end
end
