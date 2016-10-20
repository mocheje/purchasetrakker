class Purchase < ActiveRecord::Base
  attr_accessible :approved, :department_id, :item_id, :requester, :request_id, :quantity_received, :station_id, :user_id
  belongs_to :item
  belongs_to :request
  belongs_to :department
  belongs_to :station
  belongs_to :user

  scope :recent, order('id DESC')
  before_save :set_missing_params
  validates :quantity_received, numericality: true
  validates :request_id, :item_id, presence: true
  # validate :req_status
  validate :item_count





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
  def item_count
    #add validation logic for item count
    @request = Request.find(request_id)
    puts @request.inspect
    @item = @request.request_items.map{|item|
      return item.item_id == item_id
    }
    puts @item.inspect
    @purchases = Purchase.where(:request_id => request_id, :item_id => item_id)
    puts @purchases.inspect
    if @purchases
      @item_counted = 0
      @purchases.each do |purchase|
        @item_counted += purchase.quantity
        puts @item_counted        
      end
      if (@item_counted + quantity_received) > @item.quantity
        errors.add(:quantity_received, "You cannot receive more than what was requested.. Available slot is #{@item.quantity - @item_counted}")
      end

    end
  end

  def set_missing_params
    @request = Request.find(request_id)
    puts "this is the request id #{request_id}"
    self.user_id  = @request.user_id
    self.station_id = @request.department.station_id
  end
end
