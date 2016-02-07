class Purchase < ActiveRecord::Base
  attr_accessible :approved, :department_id, :item_id, :requester, :request_id, :quantity_received, :station_id, :user_id
  belongs_to :item
  belongs_to :request
  belongs_to :department
  belongs_to :station
  belongs_to :user

  scope :recent, order('id DESC')

  validates :quantity_received, numericality: true
  validates :request_id, :item_id, :station_id, presence: true
  validate :req_status



  after_create :update_inventory

  def update_inventory
    item = self.item_id
    quantity = self.quantity_received
    station = self.station_id
    @item_inventory = ItemInventory.find_by_item_id_and_station_id(item, station)
    if @item_inventory #found at leat one record
      n_quantity = @item_inventory.quantity + quantity
      @item_inventory.update_attributes({:quantity => n_quantity})
    else
      ItemInventory.create({:item_id => item, :quantity => quantity, :station_id => station})
    end
  end

  def req_status
    @request = Request.find(request_id)
    unless @request.approved?
      errors.add(:request_id, "Goods receipt can only be processed for Approved request")
    end
  end


end
